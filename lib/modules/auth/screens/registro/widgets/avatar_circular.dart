import 'dart:io';
import 'package:flutter/material.dart';

class AvatarCircularConCamara extends StatelessWidget {
  final File? imagen;
  final VoidCallback onTap;

  const AvatarCircularConCamara({
    super.key,
    required this.imagen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: imagen != null
              ? FileImage(imagen!)
              : const AssetImage('assets/images/default-image-profile.jpg')
                    as ImageProvider,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade600,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
