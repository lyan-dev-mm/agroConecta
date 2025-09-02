import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agroconecta/modules/home/messages/models/message_model.dart';

class MessageNotifier extends Notifier<List<MessageModel>> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  List<MessageModel> build() => [];

  Future<void> loadMessages(String userId, String contactId) async {
    final snapshot = await _db
        .collection('messages')
        .where('senderId', whereIn: [userId, contactId])
        .where('receiverId', whereIn: [userId, contactId])
        .orderBy('timestamp')
        .get();

    state = snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> sendMessage(MessageModel message) async {
    await _db.collection('messages').add(message.toMap());
    state = [...state, message];
  }
}

final messageProvider = NotifierProvider<MessageNotifier, List<MessageModel>>(
  () => MessageNotifier(),
);
