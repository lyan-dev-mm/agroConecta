import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = 'agro-test';
  final String uploadPreset = 'agro_preset';

  /// Sube una imagen a Cloudinary y devuelve la URL pública
  Future<String?> uploadImage({
    required File imageFile,
    required String folder, // Ej: 'perfil', 'productos', 'feed'
    String? fileName, // Opcional: nombre personalizado
  }) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folder
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    if (fileName != null) {
      request.fields['public_id'] = fileName;
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final resJson = json.decode(resStr);
      return resJson['secure_url'];
    } else {
      print('Error al subir imagen: ${response.statusCode}');
      return null;
    }
  }
}
