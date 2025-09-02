import 'package:flutter/material.dart';
import 'package:agroconecta/modules/home/messages/screens/local_messages_screen.dart';

class LocalChatsScreen extends StatefulWidget {
  final String currentUserId;

  const LocalChatsScreen({super.key, required this.currentUserId});

  @override
  State<LocalChatsScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<LocalChatsScreen> {
  String selectedFilter = 'Todos';

  final List<Map<String, dynamic>> filters = [
    {'label': 'Todos', 'icon': Icons.people},
    {'label': 'No leídos', 'icon': Icons.markunread},
    {'label': 'Favoritos', 'icon': Icons.star},
    {'label': 'Ayuda', 'icon': Icons.help_outline},
  ];

  final List<Map<String, dynamic>> chats = [
    {
      'contactId': 'user001',
      'name': 'Juan Pérez',
      'profileImage': 'https://via.placeholder.com/48',
      'lastMessage': '¿Cómo va todo?',
      'lastMessageTime': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'contactId': 'user002',
      'name': 'María López',
      'profileImage': 'https://via.placeholder.com/48',
      'lastMessage': 'Nos vemos mañana',
      'lastMessageTime': DateTime.now().subtract(const Duration(hours: 2)),
    },
  ];

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return '${time.day}/${time.month}/${time.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contactos',
          style: TextStyle(
            fontFamily: 'Franklin Gothic Demi Cond',
            color: Color(0xFF4BA43F),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Acción búsqueda
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter['label'];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedFilter = filter['label']);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4BA43F)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          filter['icon'],
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          filter['label'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LocalMessagesScreen(
                          currentUserId: widget.currentUserId,
                          contactId: chat['contactId'],
                          contactName: chat['name'],
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat['profileImage']),
                    radius: 24,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatTime(chat['lastMessageTime']),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    chat['lastMessage'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
