import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text("Perfil", style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Imagen de fondo con avatar superpuesto
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/fondo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 16,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/22/01/e9/2201e9c25c8c10690ee4ca14354b088d.jpg',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),

              const Text(
                "Piofilo Procopio",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Se unió el 19 de 2025\nUbicación: Tzapullo Postectita Chicontepec Veracruz\nDescripción: Principalmente soy citricultor pero también me dedico a la siembra de otros cultivos.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Agregar a historia",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Editar perfil",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Catálogo de publicaciones
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPublicationCard(
                      "Cultivo de naranjas",
                      'assets/images/naranjas.jpeg',
                    ),
                    _buildPublicationCard(
                      "Riego en el campo",
                      'assets/images/chile-piquin.jpeg',
                    ),
                    _buildPublicationCard(
                      "Cosecha de maíz",
                      'assets/images/mandarina.jpg',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Publicaciones",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Información",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Amigos", style: TextStyle(fontSize: 15)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Más", style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.agriculture),
                title: Text(
                  "Productor de Alimentos y otros productos Agrícolas",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home),
                title: Text("Vive en Veracruz", style: TextStyle(fontSize: 18)),
              ),
              const ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  "De Ciudad de México",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.people),
                title: Text("8000 seguidores", style: TextStyle(fontSize: 18)),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "Ver tu información",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Editar detalles",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir tarjetas de publicaciones
  Widget _buildPublicationCard(String title, String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
