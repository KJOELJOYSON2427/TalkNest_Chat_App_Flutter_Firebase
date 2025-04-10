import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;

class Cloudinaryservice {
  static const String cloudName = "dtqzaouaj";
  static const String apiKey = "668845894346329";
  static const String apiSecret = "HC0nfZLaptwo1t1Pq91XwOQyWuE";

  Future<String> uploadImage(File imageFile) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    var request = http.MultipartRequest("POST", url);
    request.fields['upload_preset'] = "TalkNest";
    request.fields['api_key'] = apiKey;
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);

    return response.statusCode == 200 ? jsonResponse['secure_url'] : null;
  }
}
