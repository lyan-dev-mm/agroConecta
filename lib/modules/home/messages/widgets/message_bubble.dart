import 'package:flutter/material.dart';
import 'package:agroconecta/modules/home/messages/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.green[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message.content),
      ),
    );
  }
}
