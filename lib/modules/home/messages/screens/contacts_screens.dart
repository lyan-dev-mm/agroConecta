import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/contact_notifier.dart';
import '../widgets/contact_title.dart';
import '../models/contact_model.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final contactNotifier = ref.read(contactProvider.notifier);

    List<ContactModel> getContactsForTab(int index) {
      switch (index) {
        case 0:
          return contactNotifier.chats;
        case 1:
          return contactNotifier.unread;
        case 2:
          return contactNotifier.favorites;
        default:
          return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chats'),
            Tab(text: 'No leídos'),
            Tab(text: 'Favoritos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (index) {
          final contacts = getContactsForTab(index);
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, i) {
              final contact = contacts[i];
              return ContactTile(
                contact: contact,
                onTap: () {
                  // Navegar a MessagesScreen
                },
              );
            },
          );
        }),
      ),
    );
  }
}
