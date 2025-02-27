import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  Future<void> sendImagesWithMetadata(
      List<File> images, List<Map<String, String>> metadata) async {
    var uri = Uri.parse("127.0.0.1:57986/upload-images/");

    var request = http.MultipartRequest("POST", uri);

    for (var image in images) {
      var multipartFile =
          await http.MultipartFile.fromPath("files", image.path);
      request.files.add(multipartFile);
    }

    // Add metadata as JSON strings
    metadata.forEach((meta) {
      request.fields["metadata"] = jsonEncode(meta);
    });
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print("Response: $responseData");
    } else {
      print("Failed to send images: ${response.reasonPhrase}");
    }
  }

  Future<void> sendImageToApi(File imageFile) async {
    // Define the Python API endpoint
    const String apiUrl = 'http://127.0.0.1:57986:<port>/upload';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Image uploaded successfully: $responseBody');
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while uploading the image: $e');
    }
  }
}
