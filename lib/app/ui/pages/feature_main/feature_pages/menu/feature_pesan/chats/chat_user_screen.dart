import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/core/models/pesan/pesan.dart';

import '../../../../../../../core/services/pesan/pesan.dart';
import '../../../../../../../core/services/preferences.dart';
import '../../../../../../../utils/snackbar/snackbar.dart';
import '../../../../../../shared/widgets/custom_list_tiles.dart';
import 'chat_screen.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({super.key});

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getChatBoxList();
    });
  }

  Future<void> getChatBoxList() async {
    final PesanServices devices = Provider.of<PesanServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    debugPrint("tokenBearer: $tokenBearer");
    debugPrint("deviceKey: $deviceKey");
    if (tokenBearer != null) {
      devices.updateDeviceListFuture(
        tokenBearer,
        deviceKey ?? '',
        showErrorSnackbar: (String errorMessage) {
          SnackbarUtil.showErrorSnackbar(context, errorMessage);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final PesanServices devices = Provider.of<PesanServices>(context, listen: false);

    return FutureBuilder<List<ChatBoxDataList>>(
      future: devices.chatBoxDataDetails, // The future is provided here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          List<ChatBoxDataList> chatBoxList = snapshot.data!;

          return ListView.builder(
            itemCount: chatBoxList.length,
            itemBuilder: (context, index) {
              final chatBox = chatBoxList[index];
              return ChatUserListTile(
                title: chatBox.messages.senderName,
                fullName: chatBox.messages.senderName,
                description: chatBox.messages.message.caption ?? '',
                time: chatBox.messages.messageTimestampStr, // Use actual data
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    ),
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
