class InternDetails {
  String? pfNumber;
  String? workEmail;
  String? department;
  String? id;
  String? dateAdded;
  String? dateModified;

  InternDetails(
      {this.pfNumber,
        this.workEmail,
        this.department,
        this.id,
        this.dateAdded,
        this.dateModified});

  InternDetails.fromJson(Map<String, dynamic> json) {
    pfNumber = json['pfNumber'];
    workEmail = json['workEmail'];
    department = json['department'];
    id = json['id'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pfNumber'] = this.pfNumber;
    data['workEmail'] = this.workEmail;
    data['department'] = this.department;
    data['id'] = this.id;
    data['dateAdded'] = this.dateAdded;
    data['dateModified'] = this.dateModified;
    return data;
  }
}