import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/learning_material_model.dart';
import 'package:dio/dio.dart';

import 'package:intern_study_guide/data/upload_model.dart';

import '../../data/intern_model.dart';

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

Future<dynamic> getUploadDetailsFromApi(url, model) async {
  var mapped = await getDataFromApi(url);
  dynamic modelDetails;
  print(mapped);

  List<UploadDetails> uploadDetails =
      mapped.map((e) => UploadDetails.fromJson(e)).toList();
  List<InternDetails> internDetails =
      mapped.map((e) => InternDetails.fromJson(e)).toList();
  List<LearningMaterialDetails> learningMaterialDetails =
      mapped.map((e) => LearningMaterialDetails.fromJson(e)).toList();
  List<ContentCreatorDetails> contentCreatorDetails =
      mapped.map((e) => ContentCreatorDetails.fromJson(e)).toList();
  if (model == 'upload') {
    modelDetails = uploadDetails;
  }
  if (model == 'intern') {
    modelDetails = internDetails;
  }
  if (model == 'learning') {
    modelDetails = learningMaterialDetails;
  }
  if (model == 'content') {
    modelDetails = contentCreatorDetails;
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

Future<dynamic> getDetailsFromApiById(url, model) async {
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
Future<void> makePatchRequest(url, test) async {

 Dio dio = new Dio();
 // final headers = {"Content-type": "application/json"};
 var incoming = test.toJson();
  //final json = {"title": "Hello", "department": '', "content":"" , "summary":"" , "duration": 8};
 // print(json);
  print(incoming);
  print('Incoming Url: '+url);
  final response = await dio.patch(url, data: incoming,);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.data}');
}

////DELETE FROM UPLOADS
Future<void> makeDeleteRequest() async {
  final url = Uri.parse(endpoints.uploadDelete());
  final response = await delete(url);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}

//note kazi ingine
/*
Future<ApiResponse<T?>> getAsync<T>(String resourcePath) async {
  //final prefs = await SharedPreferences.getInstance();
  //var token = prefs.getString(UIData.authToken);
  //var tenantId = prefs.getInt(UIData.tenantId);
  //var url = Uri.parse('$ApiEndpointUrl/$resourcePath');
  var url = Uri.parse(endpoints.uploadGetId());

  var response = await http.get(url, headers: {
    'Content-type': 'application/json',
    //'Accept': 'application/json',
    //'Authorization': 'Bearer $token',
    //'Piggy-TenantId': tenantId.toString()
  });
  return processResponse<T>(response);
}

class ApiResponse<T> {
  ApiResponse({
    required this.result,
  });

  final T result;
}

ApiResponse<T?> processResponse<T>(http.Response response) {
  try {
    // if (!((response.statusCode < 200) ||
    //     (response.statusCode >= 300) ||
    //     (response.body == null))) {
    var jsonResult = response.body;
    dynamic resultClass = jsonDecode(jsonResult);

    // print(jsonResult);

    var output = ApiResponse<T?>(
      result: resultClass,
      //success: resultClass["success"],
      //unAuthorizedRequest: resultClass['unAuthorizedRequest'],
    );

    return output;
  } catch (e) {
    return ApiResponse<T?>(
        result: null
        );
  }
}
*/
