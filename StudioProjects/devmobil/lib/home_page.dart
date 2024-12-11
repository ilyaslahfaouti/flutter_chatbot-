import 'package:flutter/material.dart';
import 'gemini.dart'; // Assure-toi que le chemin est correct

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue sur EPSIBOT'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Replace with your image asset
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/phone.jpg'), // Change the image file name as needed
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.withOpacity(0.5), Colors.grey.withOpacity(0.5)], // Semi-transparent for overlay
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Prêt à discuter ?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GeminiChatBot()),
                    );
                  },
                  child: const Text('Démarrer le ChatBot'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.orange,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
