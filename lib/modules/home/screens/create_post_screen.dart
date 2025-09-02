import 'package:agroconecta/modules/home/widgets/create_post_sheet.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nueva publicación')),
      body: CreatePostSheet(), //
    );
  }
}
