import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

void getHttp() async {
  try {
    Response response;
    var dio = Dio();
    response = await dio.get('https://localhost:7168/intern/get-all');
    String answer = response.data.toString();
    print(response.data[0]['workEmail']);
  } catch (e) {
    print(e);
  }
}

List<UploadDetails> sampleFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<UploadDetails>.from(jsonData.map((x) => UploadDetails.fromJson(x)));
}

/*String sampleToJson(List<Sample> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}*/

class UploadDetails {
  String? title;
  String? department;
  String? content;
  String? summary;
  int? duration;
  String? contentCreatorId;
  String? id;
  String? dateAdded;
  String? dateModified;

  UploadDetails({
    this.title,
    this.department,
    this.content,
    this.summary,
    this.duration,
    this.contentCreatorId,
    this.id,
    this.dateAdded,
    this.dateModified
  });
  factory UploadDetails.fromJson(Map<String, dynamic> json) {
    return UploadDetails(
        title: json['title'],
        department: json['department'],
        content: json['content'],
        summary: json['summary'],
        duration: json['duration'],
        contentCreatorId: json['contentCreatorId'],
        id: json['id'],
        dateAdded: json['dateAdded'],
        dateModified: json['dateModified']
    );
  }

}
/*Future<List<UploadDetails>> ReadJsonData(Map<String, dynamic> jsondata) async {

//read json file

  //final jsondata = await rootBundle.rootBundle.loadString('jsonfile/productlist.json');

//decode json data as list

  final list = json.decode(jsondata.toString()) as List<Map<String, dynamic>>;

//map json and initialize using DataModel

  return list.map((e) => UploadDetails.fromJson(e)).toList();
  print(list);

}*/
