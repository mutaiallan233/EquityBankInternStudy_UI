import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/learning_material_model.dart';

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

Future<dynamic> getUploadDetailsFromApi(url,model) async {
  var mapped = await getDataFromApi(url);
  dynamic modelDetails;
  print(mapped);

  List<UploadDetails> uploadDetails = mapped.map((e) => UploadDetails.fromJson(e)).toList();
  List<InternDetails> internDetails = mapped.map((e) => InternDetails.fromJson(e)).toList();
  List<LearningMaterialDetails> learningMaterialDetails= mapped.map((e) => LearningMaterialDetails.fromJson(e)).toList();
  List<ContentCreatorDetails> contentCreatorDetails = mapped.map((e) => ContentCreatorDetails.fromJson(e)).toList();
  if(model == 'upload'){
    modelDetails = uploadDetails;
  }
  if(model == 'intern'){
    modelDetails = internDetails;
  }
  if(model == 'learning'){
    modelDetails = learningMaterialDetails;
  }
  if(model == 'content'){
    modelDetails = contentCreatorDetails;
  }
  return modelDetails;
}

//////// GET UPLOADS BY ID
Future<dynamic> makeGetRequest(String api) async {

  final url = Uri.parse(api);
  Response response = await get(url);
  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map;

  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
  return decodedResponse;
}

Future<dynamic> getUploadDetailsFromApiById(url,model) async {
  var mapped = await makeGetRequest(url);
  dynamic modelDetails;
  print('Retrieved: ${mapped}');

  //// ASSIGN MODEL TO ENDPOINT
  UploadDetails uploadDetails= new UploadDetails.fromJson(mapped);
  InternDetails internDetails = new InternDetails.fromJson(mapped);
  LearningMaterialDetails learningMaterialDetails= new LearningMaterialDetails.fromJson(mapped);
  ContentCreatorDetails contentCreatorDetails = new ContentCreatorDetails.fromJson(mapped);
  if(model == 'upload'){
     modelDetails = uploadDetails;
  }
  if(model == 'intern'){
     modelDetails = internDetails;
  }
  if(model == 'learning'){
    modelDetails = learningMaterialDetails;
  }
  if(model == 'content'){
    modelDetails = contentCreatorDetails;
  }
  return modelDetails;
}
////POST TO UPLOADS
Future<void> makePostRequest() async {
  final url = Uri.parse(endpoints.uploadPost());
  //final headers = {"Content-type": "application/json"};
  //final json = '{"title": "Hello", "department": "Solution development", "content": "Classes and Constructors", "summary": "Injecting interfaces into classes and functions like a pro",  "duration": 6,  "contentCreatorId": "68e42439-b4c9-413c-b33c-f25cfb444e72"}';
  Map<String, dynamic> customer = UploadDetails(
    title: 'Dependency Injection',
    department: 'Solution development',
    content: 'Classes and Constructors',
    summary: 'Injecting interfaces into classes and functions like a pro',
    duration: 6,
    contentCreatorId: '68e42439-b4c9-413c-b33c-f25cfb444e72'
  ).toJson();
  final json = customer;
  final response = await post(url,  body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');

 // Map<String, dynamic> person = UploadDetails().toJson();
  //Map<String, dynamic> map = person.toJson();
 // person.data['title'];
  //String rawJson = jsonEncode(map);

}

////PATCH IN UPLOADS
Future<void> makePatchRequest() async {
  final url = Uri.parse(endpoints.uploadUpdate());
  final headers = {"Content-type": "application/json"};
  final json = '{"title": "Hello"}';
  final response = await patch(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
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
