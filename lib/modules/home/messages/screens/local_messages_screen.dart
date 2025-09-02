import 'package:flutter/material.dart';

class LocalMessagesScreen extends StatelessWidget {
  final String currentUserId;
  final String contactId;
  final String contactName;

  const LocalMessagesScreen({
    Key? key,
    required this.currentUserId,
    required this.contactId,
    required this.contactName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> messages = [
      {'sender': contactId, 'text': 'Hola, ¿cómo estás?'},
      {'sender': currentUserId, 'text': 'Bien, ¿y tú?'},
      {'sender': contactId, 'text': 'Todo bien, gracias.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          contactName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Franklin Gothic Demi Cond',
            color: Color(0xFF4BA43F),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final isMe = msg['sender'] == currentUserId;

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? Colors.green[300] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(msg['text']!),
            ),
          );
        },
      ),
    );
  }
}
