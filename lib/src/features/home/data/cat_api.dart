import 'dart:convert';
import 'package:http/http.dart' as http;

class CatApi {
  Future<String?> fetchCatImageUrl() async {
    final String uri = "https://api.thecatapi.com/v1/images/search";
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        return data[0]["url"] as String?;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
