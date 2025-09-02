import 'package:flutter/material.dart';

class CapacitacionScreen extends StatelessWidget {
  const CapacitacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Capacitación',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Franklin Gothic Demi Cond',
              color: Color(0xFF4BA43F),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(),
                SizedBox(height: 10),
                CategoryBar(),
                SizedBox(height: 10), // Espacio entre barras y chat
                ChatApp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CategoryItem(title: 'Filtrar', icon: Icons.filter_list),
            CategoryItem(title: 'Favoritos', icon: Icons.favorite),
            CategoryItem(title: 'Historial', icon: Icons.history),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton.icon(
        onPressed: () {
          // Lógica para filtrar productos según la categoría seleccionada
        },
        icon: Icon(icon, color: Colors.green),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 50, //  Altura fija para asegurar alineación
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 219, 215, 215),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ), //  Centra el texto verticalmente
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                Icons.search,
                color: const Color.fromARGB(255, 134, 124, 124),
              ),
            ),
            border: InputBorder.none,
            hintText: "Buscar...",
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 134, 124, 124),
              fontSize: 16,
            ),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

class ChatScreen extends StatelessWidget {
  final List<ChatItem> chats = [
    ChatItem(
      name: "Secretaria de Agricultura y desarrollo",
      message: "Programas de apollo a la produccion",
      time: "09:56 a. m.",
      icon: Icons.group,
    ),
    ChatItem(
      name: "Agrocapacitate",
      message: "programas de capacitacion...",
      time: "Yesterday",
      icon: Icons.group,
    ),
    ChatItem(
      name: "FIRA",
      message: "opera programas de SADER",
      time: "09/05/2025",
      icon: Icons.person,
    ),
    ChatItem(
      name: "Secretaria de Desarrollo gropecuaria",
      message: " Aquí encontraras capacitacion y asesoramiento",
      time: "09/05/2025",
      icon: Icons.insert_drive_file,
    ),
    ChatItem(
      name: "SMAP",
      message: "Aquí encontras capacitación especial",
      time: "09/05/2025",
      icon: Icons.person,
    ),
    ////////////////////////////////////
    ChatItem(
      name: "Secretaría de Agricultura y desarrollo",
      message: "Programas de Apollo a la Producción",
      time: "09:56 a. m.",
      icon: Icons.group,
    ),
    ChatItem(
      name: "Agrocapacitate",
      message: "Programas de capacitación...",
      time: "Ayer",
      icon: Icons.group,
    ),
    ChatItem(
      name: "Intituto Nacional de Investión",
      message: "Realiza Investigaciones y Desarrollos...",
      time: "09/05/2025",
      icon: Icons.person,
    ),
    ChatItem(
      name: "FIRA",
      message: "Opera programas de SADER",
      time: "09/05/2025",
      icon: Icons.person,
    ),
    ChatItem(
      name: "Secretaria de Desarrollo agropecuaria",
      message: " Aqui encontraras capacitacion y asesoramiento",
      time: "09/05/2025",
      icon: Icons.insert_drive_file,
    ),
    ChatItem(
      name: "SMAP",
      message: "Aqui encontras capacitacion especial",
      time: "09/05/2025",
      icon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // importante para que funcione dentro de ScrollView
      physics: NeverScrollableScrollPhysics(), // evita scroll conflictivo
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(chats[index].icon, color: Colors.green),
          title: Text(
            chats[index].name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(chats[index].message),
          trailing: Text(chats[index].time),
          onTap: () {},
        );
      },
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final IconData icon;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.icon,
  });
}
