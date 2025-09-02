import 'package:flutter/material.dart';

class RedApoyoScreen extends StatelessWidget {
  const RedApoyoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Red de apoyo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Franklin Gothic Demi Cond',
            color: Color(0xFF4BA43F),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color(0xFF4BA43F),
        elevation: 1,
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> grupos = const [
    {
      'nombre': 'Tomates',
      'fecha': '10/08/25',
      'imagen': 'assets/images/cosecha-tomate.jpg',
    },
    {
      'nombre': 'Maíz',
      'fecha': '12/08/25',
      'imagen': 'assets/images/cosecha-maiz.jpg',
    },
    {
      'nombre': 'Cítricos',
      'fecha': '15/08/25',
      'imagen': 'assets/images/cirtricos.jpeg',
    },
    {
      'nombre': 'Transporte de sandía',
      'fecha': '10/08/25',
      'imagen': 'assets/images/sandia-trans.jpeg',
    },
    {
      'nombre': 'Entrega de fertilizante',
      'fecha': '12/08/25',
      'imagen': 'assets/images/fertilizante.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildEstadisticaCard(),
          const SizedBox(height: 20),
          Expanded(child: _buildListaGrupos()),
          const SizedBox(height: 20),
          _buildBotonesInferiores(),
        ],
      ),
    );
  }

  Widget _buildEstadisticaCard() {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: const Text('Leoncio Martínez'),
        subtitle: const Text('Se conectó con 8 nuevos agricultores este mes,'),
      ),
    );
  }

  Widget _buildListaGrupos() {
    return ListView.builder(
      itemCount: grupos.length,
      itemBuilder: (context, index) {
        final grupo = grupos[index];
        return Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(grupo['imagen']!),
              radius: 25,
            ),
            title: Text('Grupo de ${grupo['nombre']}'),
            subtitle: Text('Actividad programada para ${grupo['fecha']}'),
          ),
        );
      },
    );
  }

  Widget _buildBotonesInferiores() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Acción para solicitar ayuda
          },
          icon: const Icon(Icons.help, color: Colors.green),
          label: const Text(
            'Solicitar ayuda',
            style: TextStyle(color: Color.fromARGB(255, 13, 38, 14)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 71, 231, 103),
            side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            elevation: 2,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Acción para ver conexiones
          },
          icon: const Icon(Icons.group, color: Colors.green),
          label: const Text(
            'Ver conexiones',
            style: TextStyle(color: Color.fromARGB(255, 4, 13, 4)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 71, 231, 103),
            side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            elevation: 2,
          ),
        ),
      ],
    );
  }
}
