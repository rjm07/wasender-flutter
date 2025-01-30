import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/models/pesan/pesan.dart';
import '../../../../../../../../core/models/pesan/pesan_conversation.dart';
import '../../../../../../../../core/services/pesan/pesan.dart';
import '../../../../../../../../core/services/preferences.dart';
import '../../../../../../../../core/services/socket_io/socket.dart';
import '../../../../../../../../utils/snackbar/snackbar.dart';
import '../../../../../../../shared/widgets/custom_list_tiles.dart';
import '../chat_screen.dart';

class ActiveChatScreen extends StatefulWidget {
  const ActiveChatScreen({
    super.key,
    required this.onHandleTicket,
  });
  final void Function() onHandleTicket;
  @override
  State<ActiveChatScreen> createState() => _ActiveChatScreenState();
}

class _ActiveChatScreenState extends State<ActiveChatScreen> {
  final logger = Logger();
  late String pKey = 'pKey';
  List<ChatBoxDataList> userChatBox = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getChatBoxList();
    });
    final socketService = SocketService();
    socketService.listen(false, onConnectActive);
  }

  Future<void> getChatBoxList() async {
    final PesanServices devices = Provider.of<PesanServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    debugPrint("tokenBearer: $tokenBearer");
    debugPrint("deviceKey: $deviceKey");
    pKey = deviceKey ?? '';

    if (tokenBearer != null) {
      try {
        // Update the chat box list
        await devices.updateChatBoxListFuture(
          'active',
          tokenBearer,
          deviceKey ?? '',
          showErrorSnackbar: (String errorMessage) {
            // Ensure the widget is still active
            SnackbarUtil.showErrorSnackbar(context, errorMessage);
          },
        );

        // Assign the fetched data to userChatBox
        if (mounted) {
          setState(() {
            userChatBox = devices.chatBoxDataDetails;
          });
        }
      } catch (e) {
        debugPrint("Error in getChatBoxList: $e");
      }
    }
  }

  void onConnectActive(dynamic data) {
    logger.i("Socket: Listening to active $data");

    if (data == null) {
      logger.e("Received null message");
      return;
    }
    handleIncomingMessage(data);
  }

  void handleIncomingMessage(dynamic data) {
    if (kDebugMode) {
      print('handleIncomingMessage: $data');
    }
    try {
      // Parse the incoming data into a Map
      final Map<String, dynamic> response = Map<String, dynamic>.from(data);
      final Conversation conversation = Conversation.fromJson(response);
      debugPrint('response: $response');

      if (mounted) {
        setState(() {
          // Map the Conversation object into ChatBoxDataList format
          final ChatBoxDataList newChatData = ChatBoxDataList(
            roomChat: conversation.roomChat ?? '',
            notify: conversation.notify ?? '',
            remoteJid: conversation.senderNumber ?? '',
            isBot: conversation.isBot ?? false,
            status: conversation.status.toString(),
            messages: Messages(
              agentId: conversation.agentId,
              agentName: conversation.agentName,
              broadcast: conversation.message?.caption,
              category: conversation.category ?? '',
              chat: conversation.chat ?? '',
              fromMe: conversation.fromMe ?? false,
              greeting: false, // Assuming greeting is not part of this structure
              id: conversation.id ?? '',
              message: MessageContent(
                caption: conversation.message?.caption,
                file: conversation.message?.file,
                name: conversation.message?.name,
                thumb: conversation.message?.thumb,
                mentionedJid: conversation.message?.mentionedJid ?? false,
                quotedMessage: conversation.message?.quotedMessage,
                stanzaId: conversation.message?.stanzaId,
                text: conversation.message?.text,
              ),
              messageTimestamp: conversation.messageTimestamp ?? 0,
              messageTimestampStr: conversation.messageTimestampStr ?? '',
              messageId: conversation.messageId ?? '',
              receipt: conversation.receipt ?? '',
              senderName: conversation.senderName ?? '',
              senderNumber: conversation.senderNumber ?? '',
              sessionId: conversation.pkey ?? '',
              status: conversation.status ?? 0,
              ticketId: conversation.ticketId ?? '',
              ticketNumber: conversation.ticketNumber ?? '',
              type: conversation.type ?? '',
            ),
          );

          // Check if a ChatBoxDataList with the same pkey exists
          final existingIndex = userChatBox.indexWhere((chatData) => chatData.roomChat == newChatData.roomChat);

          if (existingIndex != -1) {
            // Replace the old chat data with the new one
            userChatBox[existingIndex] = newChatData;
          } else {
            // Insert the new chat data at the beginning
            userChatBox.insert(0, newChatData);
          }
        });
      }

      final String? senderName = response['sender_name'] ?? '';
      final String? messageText = response['message']['text'] ?? '';
      final String? timestamp = response['messageTimestamp_str'] ?? '';

      debugPrint('Message from $senderName: $messageText at $timestamp');
    } catch (e) {
      debugPrint('Error processing incoming message: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PesanServices devices = Provider.of<PesanServices>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 24.0),
        child: Column(
          children: [
            Expanded(
              child: devices.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : userChatBox.isEmpty
                      ? Center(
                          child: Text(
                            "No current messages",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: userChatBox.length,
                          itemBuilder: (context, index) {
                            final chatData = userChatBox[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: ChatUserListTile(
                                title: chatData.messages.senderName,
                                fullName: chatData.messages.senderName.isEmpty
                                    ? chatData.messages.senderNumber
                                    : chatData.messages.senderName,
                                description: chatData.messages.message.text ?? '',
                                time: chatData.messages.messageTimestampStr,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        roomChat: chatData.roomChat,
                                        senderNumber: chatData.messages.senderNumber,
                                        fullName: chatData.messages.senderName,
                                        timestamp: chatData.messages.messageTimestampStr,
                                        statusIsOpen: false,
                                        onHandleTicket: widget.onHandleTicket,
                                      ),
                                    ),
                                  );
                                },
                                category: chatData.messages.category,
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
