import '../components/leave_chatai_dialog.dart';
import '../controllers/chat_controller.dart';
import '../controllers/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/chat_message_bubble.dart';
import '../components/message_input_area.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController chatController = Get.put(ChatController());
  final ChatScreenController screenController = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B6CF9),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/Logo.png'),
            ),
            const SizedBox(width: 8),
            Text(
              'Chatbot',
              style: GoogleFonts.alata(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white,),
            onPressed: () {
              // TODO: Implement close action
              showDialog(context: context, builder: (BuildContext context) => const LeaveChataiDialog(),
                barrierDismissible: false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(() => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  controller: screenController.scrollController,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController
                        .messages[chatController.messages.length - 1 - index];
                    bool isUserMessage = false;
                    String messageText = message;

                    if (message.startsWith('User: ')) {
                      isUserMessage = true;
                      messageText =
                          message.substring(6); // Remove "User: " prefix
                    } else if (message.startsWith('Bot: ')) {
                      isUserMessage = false;
                      messageText =
                          message.substring(5); // Remove "Bot: " prefix
                    }

                    return ChatMessageBubble(
                      message:
                          messageText, // Pass the message text without prefix
                      isUserMessage: isUserMessage,
                    );
                  },
                )),
          ),
          const MessageInputArea()
        ],
      ),
      backgroundColor: const Color(0xFFF3F3F3),
    );
  }

  void _handleSubmitted(String text) {
    final message = chatController.messageController.value.text;
    if (message.isNotEmpty) {
      chatController.messages.insert(0, 'User: $message');
      // chatController.sendMessage();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        /*screenController.scrollToBottom();*/
      });
    }

    chatController.messageController.value.clear();
  }
}
