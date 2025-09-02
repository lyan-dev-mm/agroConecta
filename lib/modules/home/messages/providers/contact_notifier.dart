import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact_model.dart';

// Usamos riverpod no provider

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    // Simulación de datos
    return [
      ContactModel(
        userId: 'u1',
        name: 'Juan Pérez',
        profileImageUrl: 'https://via.placeholder.com/48',
        lastMessage: '¿Cómo va la cosecha?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        isUnread: true,
        isFavorite: false,
      ),
      ContactModel(
        userId: 'u2',
        name: 'María López',
        profileImageUrl: 'https://via.placeholder.com/48',
        lastMessage: 'Te mandé el informe',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        isUnread: false,
        isFavorite: true,
      ),
    ];
  }

  List<ContactModel> get chats => state;
  List<ContactModel> get unread => state.where((c) => c.isUnread).toList();
  List<ContactModel> get favorites => state.where((c) => c.isFavorite).toList();
}

final contactProvider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);
