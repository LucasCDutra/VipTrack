import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestGet {
  static Future<dynamic> requestWithUrl(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try {
      if (httpResponse.statusCode == 200) {
        String responseData = httpResponse.body;
        var decodeReponseData = jsonDecode(responseData);
        return decodeReponseData;
      } else {
        return "Error Occured. Failed. No Response.";
      }
    } catch (e) {
      return "Error Occured. Failed. No Response.";
    }
  }
}
