import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intern_study_guide/context/api_context.dart';

import 'package:intern_study_guide/data/upload_model.dart';


EndPoints endpoints = new EndPoints();
////// GET ALL UPLOADS
Future<List> getDataFromApi(String urlprovided) async {
  var client = http.Client();
  var url = Uri.parse(urlprovided);

  try {
    var result = await client.get(url);
    var decodedResponse = jsonDecode(utf8.decode(result.bodyBytes)) as List;
    return decodedResponse;
  } finally {
    client.close();
  }
}

Future<List<UploadDetails>> getUploadDetailsFromApi(String api) async {
  var list = await getDataFromApi(api);
  print(list);
  return list.map((e) => UploadDetails.fromJson(e)).toList();
}

//////// GET UPLOADS BY ID
Future<Map<String, dynamic>> makeGetRequest(String api) async {
  var client = http.Client();

  final url = Uri.parse(api);
  Response response = await get(url);
  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
  return decodedResponse;
}
Future<UploadDetails> getUploadDetailsFromApiById(url) async {
  var mapped = await makeGetRequest(url);
  print('Retrieved: ${mapped}');
  print('IAM WORKING');
  return UploadDetails.fromJson(mapped);
}

////POST TO UPLOADS
Future<void> makePostRequest() async {
  final url = Uri.parse(endpoints.uploadPost());
  final headers = {"Content-type": "application/json"};
  final json = '{"title": "Hello", "body": "body text", "userId": 1}';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}