import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intern_study_guide/data/upload_model.dart';

Future<List> getDataFromApi(String urlprovided) async {
  var client = http.Client();

  var url = Uri.parse(urlprovided);

  try {
    var result = await client.get(url);

    print("test three complete");

    var decodedResponse = jsonDecode(utf8.decode(result.bodyBytes)) as List;

    print("test four complete");

    return decodedResponse;
  } finally {
    client.close();
  }
}

Future<List<UploadDetails>> getUploadDetailsFromApi(String api) async {
  print("test one complete");

  var list = await getDataFromApi(api);

  print("test five complete");

  print(list[0]);

  return list.map((e) => UploadDetails.fromJson(e)).toList();
}
