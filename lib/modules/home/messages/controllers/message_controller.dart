import 'package:flutter/material.dart';

class MessageController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void dispose() {
    textController.dispose();
    scrollController.dispose();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
