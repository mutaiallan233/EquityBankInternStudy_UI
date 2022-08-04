
/*class UploadDetails {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
        data['title'] = this.title;
        data['department'] = this.department;
        data['content'] = this.content;
        data['summary'] = this.summary;
        data['duration'] = this.duration;
        data['contentCreatorId'] = contentCreatorId;
       //id: json['id']?? 'id null',
        //dateAdded: json['dateAdded'].toString(),
        //dateModified: json['dateModified'].toString()
    return data;
  }

}*/
/*Future<List<UploadDetails>> ReadJsonData(Map<String, dynamic> jsondata) async {

  final list = json.decode(jsondata.toString()) as List<Map<String, dynamic>>;

//map json and initialize using DataModel

  return list.map((e) => UploadDetails.fromJson(e)).toList();
  print(list);

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

  UploadDetails(
      {this.title,
        this.department,
        this.content,
        this.summary,
        this.duration,
        this.contentCreatorId,
        this.id,
        this.dateAdded,
        this.dateModified});

  UploadDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    department = json['department'];
    content = json['content'];
    summary = json['summary'];
    duration = json['duration'];
    contentCreatorId = json['contentCreatorId'];
    id = json['id'];
    dateAdded = json['dateAdded'].toString();
    dateModified = json['dateModified'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['department'] = this.department;
    data['content'] = this.content;
    data['summary'] = this.summary;
    data['duration'] = this.duration;
    data['contentCreatorId'] = this.contentCreatorId;
    //data['id'] = this.id;
    //data['dateAdded'] = this.dateAdded;
    //data['dateModified'] = this.dateModified;
    return data;
  }
}