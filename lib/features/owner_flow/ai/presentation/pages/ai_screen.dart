import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2CC3B5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Row(
            children: [
              Image.asset(
                "assets/images/Vector(1).png",
                height: 15,
              ),
              const SizedBox(width: 6),
              const Text(
                "Ai assistant",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF6F6F6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF2CC3B5).withValues(alpha:  0.15),
                  child: Image.asset(
                    "assets/images/Vector(1).png",
                    height: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi! I'm Rifq, your smart pet assistant",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "How can I help you today?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),

                // Icons
                Column(
                  children: [
                    Icon(Icons.copy, color: Colors.black45, size: 20),
                    const SizedBox(height: 6),
                    Icon(Icons.share_outlined, color: Colors.black45, size: 20),
                  ],
                )
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
              ],
            ),
            child: Row(
              children: [
                // Images icon
                IconButton(
                  icon: const Icon(Icons.image_outlined,
                      color: Colors.black54, size: 26),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined,
                      color: Colors.black54, size: 26),
                  onPressed: () {},
                ),

                // TextField
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Ask me anything....",
                        hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF2CC3B5),
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
