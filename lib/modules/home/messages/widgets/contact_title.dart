import 'package:flutter/material.dart';
import 'package:agroconecta/modules/home/messages/models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onTap;

  const ContactTile({super.key, required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(contact.profileImageUrl),
        radius: 24,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            contact.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _formatTime(contact.lastMessageTime),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(
        contact.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return '${time.day}/${time.month}/${time.year}';
  }
}
