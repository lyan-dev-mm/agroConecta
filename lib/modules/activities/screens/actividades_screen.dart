import 'package:flutter/material.dart';

class ActividadesScreen extends StatelessWidget {
  const ActividadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de actividades'),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF4BA43F),
        elevation: 1,
      ), // AppBar personalizado
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
