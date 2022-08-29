import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class GenericService<T> {
  Dio dio = Dio();
  //final String apiUrl = "https://ab48-197-232-61-244.eu.ngrok.io/api/";
  //String authurl = "https://api-omnichannel-dev.azure-api.net/v2.1/oauth/token";
  //String auth = "";

/*
  Future<String> generateAuth() async {
    Response resp = await dio.post(authurl,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }),
        data:
        "client_secret=OTI0QUFGRTMtMjc3My00QUNELUFGMzktQjkzQzUwNzA4RjhD&client_id=A39A9A4B8B8D406&grant_type=client_credentials");
    var result = TokenModel.fromJson(jsonDecode(resp.data));
    return result.accessToken.toString();
  }
*/

  Future create(String url, T data) async {
    //auth = await generateAuth();
    var stringencoded = jsonEncode(data);
    print(stringencoded);
    Response response = await dio.post(url, data: stringencoded);
    return data;
  }

  Future<List<T>> getAll(
      T Function(Map<String, dynamic>) fromJson, String url) async {
    // auth = await generateAuth();

    List<T> data = [];
    Response response = await dio.get(
      url,
    );
    var result = (response.data);
    for (var element in result) {
      data.add(fromJson(element));
    }
    return data;
  }

  Future<T> get(
      T Function(Map<String, dynamic>) fromJson, String url, String id) async {
    // auth = await generateAuth();

    Response response = await dio.get(
      '$url/$id',
    );
    var result = (response.data);
    return fromJson(result);
  }

  Future<T> update(T data, String url, String id) async {
    // auth = await generateAuth();

    var stringvalues = jsonEncode(data);
    Response response = await dio.patch(
      '$url/$id',
      data: stringvalues,
    );
    return data;
  }

  Future<bool> delete(String id, String url) async {
    //auth = await generateAuth();
print('$url/$id');
    Response response = await dio.delete(
      '$url/$id',
    );
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  ///Dealing with otps
  //verifyOtp
  ///TODO: email auth later
  /*Future<bool> verifyOtp(String url, VerifyOtpModel model) async {
    auth = await generateAuth();

    Response response = await dio.post('$apiUrl$url',
        data: jsonEncode(model),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: auth,
        }));
    if (response.statusCode == 201) {
      var responsegot = OtpResponseModel.fromJson(response.data);
      if (responsegot.successful == true) {
        return true;
      }
    }
    return false;
  }

//RegenerateOtp
  Future<bool> regenerateOtp(String url, VerifyOtpModel model) async {
    auth = await generateAuth();

    Response response = await dio.post('$apiUrl/$url',
        data: jsonEncode(model.reference),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: auth,
        }));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }*/
}
