import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class LeaveChataiDialog extends StatelessWidget {
  const LeaveChataiDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: SizedBox(
        width: 140,
        child: Text(
          'Are you sure you want to leave?',
          style: GoogleFonts.fredoka(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: 220,
        child: Text(
          'You will lose all your chat history once you leave the app.',
          style: GoogleFonts.fredoka(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 32)),
                backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFE2E2E2)),
                textStyle: WidgetStatePropertyAll(GoogleFonts.fredoka()),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',style: TextStyle(color: Colors.black, fontSize: 12),),

            ),
            TextButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 32)),
                backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFFB4741)),
                textStyle: WidgetStatePropertyAll(GoogleFonts.fredoka()),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Leave', style: TextStyle(color: Colors.white, fontSize: 12),),
            ),
          ],
        )
      ],
    );

    void _closeApp() {
      SystemNavigator.pop();
      print('App closed');
    }
  }
}
