import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpUtil {
  static String baseUrl = "http://10.0.2.2:5000/";

  static Future<http.Response> getData(String uri) async {
    final response = await http.get(baseUrl + uri,
      headers: <String, String>{
        'x-api-key': 'sua_app_key',
      },
    );
    return response;
  }

  static Future<http.Response> getDataId(String uri, String id) async {
    final response = await http.get(baseUrl + uri + '/'  + id);
    return response;
  }

  static Future<http.Response> removeData(String uri, String id) async {
    final response = await http.delete(baseUrl + uri + '/'  + id,
      headers: <String, String>{
        'x-api-key': 'sua_app_key',
      },
    );
    return response;
  }

  static Future<http.Response> addData(String uri, Map<String, Object> data) async {
    final response = await http.post(
      baseUrl + uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<http.Response> editData(String uri, Map<String, Object> data,
      String id) async {
    final response = await http.put(
      baseUrl + uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response;
  }


}