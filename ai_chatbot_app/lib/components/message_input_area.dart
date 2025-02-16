import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/chat_controller.dart'; // Import ChatController

class MessageInputArea extends StatelessWidget {
  const MessageInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController =
        Get.find(); // Find the existing ChatController

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 180.0
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Color.from(alpha: 0.3, red: 255, green: 255, blue: 255),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 1),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Obx(() => TextField(
                      maxLines: null,
                      // keyboardType: TextInputType.multiline,
                      // Wrap TextField in Obx to listen to controller changes if needed
                      controller: chatController.messageController
                          .value, // Access TextEditingController using .value
                      onSubmitted: (_) => chatController
                          .sendMessage(), // Call sendMessage on submit
                      decoration: InputDecoration.collapsed(
                          hintText: 'Write a message',
                          hintStyle: GoogleFonts.fredoka(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                    )),
              ),
              IconButton(
                padding: const EdgeInsets.all(8.0),
                icon: const Icon(Icons.send, color: Color(0xFF5B6CF9),),
                onPressed: () => chatController
                    .sendMessage(), // Call sendMessage on button press
              ),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ),
    );
  }
}
