import 'dart:convert';
import 'dart:developer';

import 'package:ai_image_generator/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class OpenAIAPI {
  static final url = Uri.parse(ConstantAPI.baseUrl);

  static final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${ConstantAPI.apiKey}"
  };

  static generateImage({required String text, required String size}) async {
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"prompt": text, "n": 1, "size": size}),
    );
    
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      log("Success Data => $data");
      return data['data'][0]['url'].toString();
    } else {
      log("Failed to fetch Image");
    }
  }
}
