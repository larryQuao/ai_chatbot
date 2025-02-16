import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // Import dart:convert for JSON encoding/decoding
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController().obs;
  final messages = <String>[].obs;
  final backendUrl = 'http://127.0.0.1:8000/chat'; // Backend API URL

  String? _conversationId;

  void onInit() {
    super.onInit();

    _conversationId = const Uuid().v4();
  }

  Future<void> sendMessage() async { // Make sendMessage async and return Future<void>
    final message = messageController.value.text;
    if (message.isNotEmpty) {
      messages.add('User: $message');
      messageController.value.clear();

      try {
        final response = await http.post(
          Uri.parse(backendUrl), // Convert URL string to Uri
          headers: {'Content-Type': 'application/json'}, // Set content type to JSON
          body: jsonEncode({'message': message, 'conversation_id': _conversationId}), // Encode message as JSON
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body); // Decode JSON response
          final botResponse = responseData['response']; // Extract 'response' field
          messages.add('Bot: $botResponse'); // Add bot response to messages
        } else {
          messages.add('Bot: Error communicating with chatbot backend.'); // Error message if API call fails
          print('Backend API Error: ${response.statusCode}'); // Log error status code
        }
      } catch (e) {
        messages.add('Bot: Error communicating with chatbot backend.'); // General error message
        print('Error sending message: $e'); // Log exception
      }
    }
  }

  @override
  void onClose() {
    messageController.value.dispose();
    super.onClose();
  }
}