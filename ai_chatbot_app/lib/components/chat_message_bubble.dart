import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/chat_controller.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message, required this.isUserMessage});

  final String message;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: isUserMessage
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isUserMessage)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child:
              isUserMessage
                ? null
                : const CircleAvatar(
                  backgroundImage: AssetImage('assets/Logo.png'),
                ),
            )
          else
              const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                  isUserMessage ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUserMessage ? const Color(0xFFD6D6D6) : const Color(0xFFFFFFFF),
                      borderRadius: isUserMessage
                          ? const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topRight: Radius.zero,
                        bottomRight: Radius.circular(8.0),
                      )
                          : const BorderRadius.only(
                        topLeft: Radius.zero,
                        bottomLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Text(message, style: GoogleFonts.fredoka(fontWeight: FontWeight.normal, fontSize: 14), textAlign: isUserMessage ? TextAlign.left : TextAlign.left),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
