import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const VoiceAssistantUI());
}

class VoiceAssistantUI extends StatelessWidget {
  const VoiceAssistantUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Assistant',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  String selectedLang = "Bangla";

  @override
  void initState() {
    super.initState();
    _glowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Voice Assistant",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            double glow = 10 + (_glowController.value * 20);
            return Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    blurRadius: glow,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Language Select
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      langButton("Bangla"),
                      langButton("English"),
                      langButton("Hindi"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Mic Button
                  GestureDetector(
                    onTap: () {
                      // পরে Mic logic বসবে
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Text Output Card
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "🎤 আপনার কথা এখানে দেখাবে...",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget langButton(String lang) {
    bool active = selectedLang == lang;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ChoiceChip(
        label: Text(lang),
        selected: active,
        onSelected: (_) {
          setState(() {
            selectedLang = lang;
          });
        },
        selectedColor: Colors.blueAccent,
        labelStyle: TextStyle(
          color: active ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
