import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:wasender/app/core/models/pesan/pesan_conversation.dart';

import '../../../../../../../core/services/local_notifications/local_notifications.dart';
import '../../../../../../../core/services/pesan/pesan.dart';
import '../../../../../../../core/services/preferences.dart';
import '../../../../../../../core/services/socket_io/socket.dart';
import '../../../../../../../utils/lang/images.dart';
import '../../../../../../shared/widgets/avatar_with_initials.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/handle_ticket.dart';
import '../../../../../../shared/widgets/msg_widget/other_msg_widget.dart';
import '../../../../../../shared/widgets/msg_widget/own_msg_widget.dart';
import '../pesan_screen.dart';
import 'chat_user_profile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.fullName,
      required this.timestamp,
      required this.roomChat,
      required this.senderNumber,
      required this.statusIsOpen});

  final String fullName;
  final String timestamp;
  final String roomChat;
  final String senderNumber;
  final bool statusIsOpen;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final logger = Logger();
  late socket_io.Socket? socket;
  final SocketService socketService = SocketService();
  final TextEditingController _controller = TextEditingController();

  List<Conversation> _messages = [];
  final ScrollController _scrollController = ScrollController(); // Step 1: ScrollController
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    debugPrint('status ${widget.statusIsOpen}');
    socket = socketService.initializeSocket();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getChatBoxConversation();
      listenToIncomingMessages();
    });
  }

  Future<void> getChatBoxConversation() async {
    final PesanServices devices = Provider.of<PesanServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    debugPrint("tokenBearer: $tokenBearer");
    debugPrint("deviceKey: $deviceKey");

    if (tokenBearer != null) {
      final converse = await devices.getChatBoxConversation(tokenBearer, deviceKey!, widget.roomChat);
      final List<Conversation> conversation = converse.toList();
      setState(() {
        _messages = conversation;
      });
    }
  }

  void listenToIncomingMessages() async {
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    final String? fkUserID = await LocalPrefs.getFKUserID();

    if (deviceKey == null || fkUserID == null) {
      throw Exception("DeviceKey or FKUserID is null");
    }

    if (socket == null) {
      throw Exception("Socket is not initialized");
    }

    socket!.onConnect((_) {
      debugPrint('Connection Established');
      final channel = "popup:${fkUserID}_$deviceKey";
      socket!.on(channel, (msg) {
        logger.i("Socket: Listening (1) on $channel");
        debugPrint(channel);
        handleIncomingMessage(msg);
      });
    });
  }

  void handleIncomingMessage(dynamic data) {
    try {
      // Parse the incoming data
      final Map<String, dynamic> response = Map<String, dynamic>.from(data);
      final Conversation conversation = Conversation.fromJson(response);
      debugPrint('response: $response');
      if (mounted) {
        setState(() {
          _messages.add(conversation);
        });
      }

      final String senderName = response['sender_name'] ?? '';
      final String messageText = response['message']['text'] ?? '';
      final String timestamp = response['messageTimestamp_str'] ?? '';

      debugPrint('Message from $senderName: $messageText at $timestamp');
    } catch (e) {
      debugPrint('Error processing incoming message: $e');
    }
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final PesanServices devices = Provider.of<PesanServices>(context, listen: false);
      final String? whatsappNumber = await LocalPrefs.getWhatsappNumber();

      String msg = _controller.text;

      // Send the message through the API
      devices.sendMessage(
        widget.roomChat,
        whatsappNumber ?? '',
        widget.senderNumber,
        msg,
      );
    }

    _controller.clear();
  }

  // @override
  // void dispose() {
  //   // Cancel the listener or subscription here
  //   socketService.closeSocket();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final PesanServices devices = Provider.of<PesanServices>(context);
    DateTime dateTime = DateTime.parse(widget.timestamp);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    String formattedTime = DateFormat('H:mm a').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChatUserProfileScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: AvatarWithInitials(
                    fullName: (widget.fullName.isEmpty || double.tryParse(widget.fullName) != null)
                        ? 'Whatup Sender'
                        : widget.fullName,
                    imageUrl: null,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.fullName,
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'last updated on $formattedDate at $formattedTime',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.green),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatUserProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                reverse: true, // Makes the ListView start from the bottom
                controller: _scrollController, // Attach the scroll controller
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  // Use reversed index to display messages in descending order
                  final reversedIndex = _messages.length - 1 - index;
                  final message = _messages[reversedIndex];
                  if (message.fromMe == true) {
                    return OwnMsgWidget(
                      status: message.status, // Example status
                      time: message.messageTimestampStr, // Example time
                      ownMessage: message.message.text,
                    );
                  } else {
                    return OthersMsgWidget(
                      status: message.status, // Example status
                      time: message.messageTimestampStr, // Example time
                      ownMessage: message.message.text,
                    );
                  }
                },
              ),
            ),
          ),
          widget.statusIsOpen == true
              ? Container(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ListTileTheme(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ExpansionTile(
                                  showTrailingIcon: false,
                                  tilePadding: EdgeInsets.zero,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (bool expanded) {
                                    setState(() {
                                      isExpanded = expanded;
                                    });
                                  }, // Hide the default trailing icon
                                  title: Icon(
                                    isExpanded ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                                    size: 32.0,
                                  ),
                                  children: [
                                    Text(
                                      "I N F O R M A T I O N",
                                      style: TextStyle(fontSize: 20, color: Colors.black38),
                                    ),
                                    SizedBox(height: 8),
                                    HandleStatusLabelWidget(
                                        icon: CustomIcons.iconHTStatus,
                                        title: 'Status',
                                        status: widget.statusIsOpen ? 'OPEN' : ''),
                                    SizedBox(height: 8),
                                    HandleGenericLabelWidget(
                                        icon: CustomIcons.iconHTIncomingEmail,
                                        title: 'Incoming Message at',
                                        value: '09/12/2024 13:58:47'),
                                    SizedBox(height: 8),
                                    HandleGenericLabelWidget(
                                        icon: CustomIcons.iconHTClock,
                                        title: 'Incoming Message at',
                                        value: '09/12/2024 13:58:47'),
                                    SizedBox(height: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 4),
                          child: Row(
                            children: [
                              SizedBox(height: 8),
                              Image.asset(CustomIcons.iconHTAttention, color: Colors.black87, height: 28, width: 28),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Attention, this conversation needs your support, click handle this customer.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        WidgetButton(
                          onPressed: () {
                            _handleTicket(context, devices, widget.roomChat, widget.senderNumber);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(CustomIcons.iconHandleTicket, height: 20, width: 20),
                              SizedBox(width: 8),
                              Text(
                                "Handle Ticket",
                                style: TextStyle(fontSize: 16, color: Colors.white), //
                              ),
                            ], // TOD)
                          ), //
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.green[700]),
                        onPressed: () {
                          // Add functionality for adding an attachment
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                        onPressed: () {
                          debugPrint('emoji button pressed');
                          LocalNotificationsServices()
                              .showNotification('Testing', 'This is just a sample for Firebase');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.green),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

void _handleTicket(BuildContext context, PesanServices pesanServices, String roomChat, String customerWhatsapp) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Handle Ticket"),
        content: const Text("Are you sure you want to handle this ticket?"),
        actions: <Widget>[
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PesanScreen(initialPageIndex: 0),
                ),
              );
              pesanServices.assignTicket(roomChat, customerWhatsapp);
            },
          ),
        ],
      );
    },
  );
}
