import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/learning_material_model.dart';
import 'package:dio/dio.dart';

import 'package:intern_study_guide/data/upload_model.dart';

import '../data/intern_model.dart';

EndPoints endpoints = new EndPoints();
Dio dio = Dio();
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

Future<dynamic> getUploadDetailsFromApi(url, model) async {
  var mapped = await getDataFromApi(url);
  dynamic modelDetails;
  print(mapped);

  if (model == 'upload') {
    modelDetails = mapped.map((e) => UploadDetails.fromJson(e)).toList();
  }
  if (model == 'intern') {
    modelDetails = mapped.map((e) => InternDetails.fromJson(e)).toList();
  }
  if (model == 'learning') {
    modelDetails =
        mapped.map((e) => LearningMaterialDetails.fromJson(e)).toList();
  }
  if (model == 'content') {
    modelDetails =
        mapped.map((e) => ContentCreatorDetails.fromJson(e)).toList();
  }
  return modelDetails;
}

//////// GET UPLOADS BY ID
Future<dynamic> makeGetRequest(String api) async {
  final url = Uri.parse(api);
  var response = await get(url);
  var decodedResponse = jsonDecode(response.body);

  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
  return decodedResponse;
}

Future<dynamic> getDetailsFromApiById(String url, model) async {
  var mapped = await makeGetRequest(url);
  dynamic modelDetails;
  print('Retrieved: ${mapped}');



  //// ASSIGN MODEL TO ENDPOINT
  if (model == 'upload') {
    modelDetails = new UploadDetails.fromJson(mapped);
  }
  if (model == 'intern') {
    modelDetails = new InternDetails.fromJson(mapped);
  }
  if (model == 'learning') {
    modelDetails = new LearningMaterialDetails.fromJson(mapped);
  }
  if (model == 'content') {
    modelDetails = new ContentCreatorDetails.fromJson(mapped);
  }
  return modelDetails;
}

////POST TO UPLOADS
Future<void> makePostRequest(String url, dynamic test) async {
  Map<String, dynamic> incoming = test.toJson();

  print(incoming);
  Dio dio = new Dio();

  var responseDio = await dio.post(url, data: incoming);
  print(responseDio.statusCode);
  print(responseDio.data);
}

////PATCH IN UPLOADS
Future<void> makePatchRequest(String url, test) async {
  Dio dio = new Dio();
  var incoming = test.toJson();
  print(incoming);
  print('Incoming Url: ' + url);
  final response = await dio.patch(
    url,
    data: incoming,
  );
  print('Status code: ${response.statusCode}');
  print('Body: ${response.data}');
}

////DELETE FROM UPLOADS
Future<void> makeDeleteRequest(String url) async {
  Dio dio = new Dio();
  final response = await dio.delete(url);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.data}');
}

