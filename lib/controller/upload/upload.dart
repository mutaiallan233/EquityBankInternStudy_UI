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
  //var client = http.Client();

  final url = Uri.parse(api);
  Response response = await get(url);
  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

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
/*Future<Map<String, dynamic>> makePostRequest() async {
  final url = Uri.parse(endpoints.uploadPost());
  final headers = {"Content-type": "application/json"};
  final json = '{"title": "Solid Principles","department": "Integrations department","content": "Programmer Best Practicers","summary": "Structure your code responsibly","duration": 5,"contentCreatorId": "3a898ee3-787b-4e35-b1d9-ef71e22f1747"}';
  final response = await post(url, headers: headers, body: json);
  //var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');

 */ /* UploadDetails  details = UploadDetails("title": "Solid Principles","department": "Integrations department","content": "Programmer Best Practicers","summary": "Structure your code responsibly","duration": 5,"contentCreatorId": "3a898ee3-787b-4e35-b1d9-ef71e22f1747");
  Map<String, dynamic> map = person.toJson();
  String rawJson = jsonEncode(map);

  return decodedResponse;*/ /*
}*/

/*Future<UploadDetails> patchUploadDetails() async{
  var mapped = await makePostRequest();
  print('AM WORKING!');
  return UploadDetails.toJson(mapped);
}*/

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
