import 'package:flutter/material.dart';
import 'dart:ui'; // Import this for BackdropFilter
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color lightGray = Color(0xFFD9D9D9);
  static const Color mediumGray = Color(0xFFB0B0B0);
  static const Color darkGray = Color(0xFF7D7D7D);
  static const Color orange = Color(0xFFFFA500);
  static const Color white = Color(0xFFFFFFFF);
}

class MessageModel {
  final String content;
  final bool isUser;
  final DateTime date;

  MessageModel({required this.content, required this.isUser, required this.date});
}

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  static const apiKey = 'AIzaSyBwpZJe_hRp_R3yXZtSnWRp7JDXUvs9uS4'; // Replace with your actual API key
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<MessageModel> chat = [];
  final TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  Future<void> sendMessage() async {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      chat.add(MessageModel(content: message, isUser: true, date: DateTime.now()));
      isLoading = true;
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      chat.add(MessageModel(content: response.text ?? "No response", isUser: false, date: DateTime.now()));
      messageController.clear();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: AppColors.mediumGray,
        title: const Text('EPSIBOT', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image with blur effect
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/phone.jpg'), // Change the image file name as needed
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Reduced blur effect
            child: Container(
              color: Colors.black.withOpacity(0.3), // Adjusted overlay color for better visibility
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Que puis-je faire pour vous ?',
                  style: TextStyle(fontSize: 18, color: AppColors.white),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chat.length,
                  itemBuilder: (context, index) {
                    final message = chat[index];
                    return userPrompt(
                      isUser: message.isUser,
                      message: message.content,
                      date: DateFormat('hh:mm a').format(message.date),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.black, fontSize: 17),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Écrivez votre message...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: isLoading ? null : sendMessage,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.orange,
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            : const Icon(Icons.send, color: Colors.white, size: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container userPrompt({required bool isUser, required String message, required String date}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10).copyWith(
        left: isUser ? 15 : 0,
        right: isUser ? 80 : 15,
      ),
      decoration: BoxDecoration(
        color: isUser ? AppColors.white : AppColors.darkGray,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(message, style: TextStyle(color: isUser ? AppColors.darkGray : AppColors.white)),
          Text(date, style: const TextStyle(color: AppColors.darkGray, fontSize: 12)),
        ],
      ),
    );
  }
}
