

class UploadDetails {
  String? title;
  String? department;
  String? content;
  String? summary;
  dynamic duration;
  dynamic contentCreatorId;
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
    data['title'] = this.title ?? '';
    data['department'] = this.department?? '';
    data['content'] = this.content?? '';
    data['summary'] = this.summary?? '';
    data['duration'] = this.duration;
    data['contentCreatorId'] = this.contentCreatorId?? '';
    //data['id'] = this.id;
    //data['dateAdded'] = this.dateAdded;
   // data['dateModified'] = this.dateModified;
    return data;
  }
}