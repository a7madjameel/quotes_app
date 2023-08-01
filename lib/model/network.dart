import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app/utilities/constants.dart';

class NetworkHelper {
  static Future<Map<String, dynamic>> getQuotesData() async {
    http.Response response = await http.get(Uri.parse(quotesKey));
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
    return Future.error("something wrong");
  }

  static Future<Map<String, dynamic>> getImageData(String tags) async {
    http.Response response = await http.get(Uri.parse(
        'https://random.imagecdn.app/v1/image?category=$tags&format=json'));
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
    return Future.error("something wrong");
  }
}
