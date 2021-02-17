import 'package:http/http.dart' as http;

class HttpUtil {
  static Future<http.Response> getData(String uri) async {
    final response = await http.get(uri);
    return response;
  }
}