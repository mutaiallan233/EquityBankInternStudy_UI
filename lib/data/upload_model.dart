import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:flutter/services.dart';


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
        title: json['title'] ?? 'title null',
        department: json['department']?? 'department null',
        content: json['content']?? 'content null',
        summary: json['summary']?? 'summary null',
        duration: json['duration']?? 0,
        contentCreatorId: json['contentCreatorId']?? 'contentCreatorID null',
        id: json['id']?? 'id null',
        dateAdded: json['dateAdded'].toString(),
        dateModified: json['dateModified'].toString()
    );
  }

}
/*Future<List<UploadDetails>> ReadJsonData(Map<String, dynamic> jsondata) async {

  final list = json.decode(jsondata.toString()) as List<Map<String, dynamic>>;

//map json and initialize using DataModel

  return list.map((e) => UploadDetails.fromJson(e)).toList();
  print(list);

}*/
