import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Marketplace',
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
                SizedBox(height: 10),
                AdvertisementWidget(),
                SizedBox(height: 20),
                Text(
                  "Frutas y Verduras",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                VisualCategoryBar(), // Nueva sección visual
                // Sección de publicidad
                SizedBox(height: 20),
                Text(
                  "Productos: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),

                SizedBox(height: 10),
                SizedBox(height: 600, child: ProductGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VisualCategoryBar extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Naranja', 'image': 'assets/images/naranjas.jpeg'},
    {'name': 'Sandía', 'image': 'assets/images/chile-piquin.jpeg'},
    {'name': 'Frijol', 'image': 'assets/images/mandarina.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(categories[index]['image']!),
                ),
                SizedBox(height: 5),
                Text(
                  categories[index]['name']!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AdvertisementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  'assets/images/mandarina.jpg',
                  width: 250,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/naranjas.jpeg',
                  width: 250,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'assets/image/perfil.jpg',
                  width: 250,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () {
                // Manejo del cierre del anuncio publicitario
              },
            ),
          ),
        ],
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
            CategoryItem(title: 'Favoritos', icon: Icons.favorite),
            CategoryItem(title: 'Historial', icon: Icons.history),
            CategoryItem(title: 'Siguiendo', icon: Icons.person_add),
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
        icon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
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
            hintText: "Buscar producto",
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

class ProductGrid extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'name': 'Verduras mayoreo\n  \$150',
      'image': 'assets/images/naranjas.jpeg',
    },
    {
      'name': 'Naranja por mayoreo\n \$550',
      'image': 'assets/images/mandarina.jpg',
    },
    {
      'name': 'Cebolla Morada\n \$500',
      'image': 'assets/images/chile-piquin.jpeg',
    },
    {
      'name': 'Todo tipo de verdura\n \$100',
      'image': 'assets/images/chile-piquin.jpeg',
    },
    {'name': 'Zanahoria\n \$80', 'image': 'assets/images/naranjas.jpeg'},
    {
      'name': 'Verduras todo tipo\n  \$234',
      'image': 'assets/images/mandarina.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    products[index]['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  products[index]['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
