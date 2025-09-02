import 'package:agroconecta/modules/home/messages/screens/local_chats_screen.dart';
import 'package:agroconecta/modules/home/messages/screens/local_messages_screen.dart';
import 'package:agroconecta/modules/home/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Screens
import 'package:agroconecta/modules/home/messages/screens/contacts_screens.dart';
import 'package:agroconecta/modules/home/messages/screens/message_screen.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Título centrado
          const Text(
            'AgroConect@',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Franklin Gothic Demi Cond',
              color: Color(0xFF4BA43F),
            ),
          ),

          // Íconos de búsqueda y mensajes agrupados a la derecha
          Row(
            children: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4BA43F),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
                onPressed: () {
                  // Acción búsqueda
                  final currentUserId =
                      FirebaseAuth.instance.currentUser?.uid ?? '';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          SearchScreen(currentUserId: currentUserId),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4BA43F),
                  ),
                  child: const Icon(Icons.message, color: Colors.white),
                ),
                onPressed: () {
                  // Acción mensajes
                  final currentUserId =
                      FirebaseAuth.instance.currentUser?.uid ?? '';
                  final contactId = 'user001'; // 👈 Simulado
                  final contactName = 'Juan Pérez'; // 👈 Simulado

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          LocalChatsScreen(currentUserId: currentUserId),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
