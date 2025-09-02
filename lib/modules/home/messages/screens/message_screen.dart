import 'package:agroconecta/modules/home/messages/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/modules/home/messages/models/message_model.dart';
import 'package:agroconecta/modules/home/messages/widgets/message_bubble.dart';
import 'package:agroconecta/modules/home/messages/controllers/message_controller.dart';

class MessagesScreen extends ConsumerStatefulWidget {
  final String currentUserId;
  final String contactId;

  const MessagesScreen({
    super.key,
    required this.currentUserId,
    required this.contactId,
  });

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  late MessageController controller;

  @override
  void initState() {
    super.initState();
    controller = MessageController();
    Future.microtask(() {
      ref
          .read(messageProvider.notifier)
          .loadMessages(widget.currentUserId, widget.contactId);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = controller.textController.text.trim();
    if (content.isEmpty) return;

    final message = MessageModel(
      id: '', // Firestore lo genera
      senderId: widget.currentUserId,
      receiverId: widget.contactId,
      content: content,
      timestamp: DateTime.now(),
    );

    ref.read(messageProvider.notifier).sendMessage(message);
    controller.textController.clear();
    controller.scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mensajes')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.senderId == widget.currentUserId;
                return MessageBubble(message: message, isMe: isMe);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
