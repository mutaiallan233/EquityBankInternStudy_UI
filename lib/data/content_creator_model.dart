class ContentCreatorDetails {
  String? workEmail;
  String? department;
  String? role;
  String? id;
  String? dateAdded;
  String? dateModified;

  ContentCreatorDetails(
      {this.workEmail,
        this.department,
        this.role,
        this.id,
        this.dateAdded,
        this.dateModified});

  ContentCreatorDetails.fromJson(Map<String, dynamic> json) {
    workEmail = json['workEmail'];
    department = json['department'];
    role = json['role'];
    id = json['id'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workEmail'] = this.workEmail;
    data['department'] = this.department;
    data['role'] = this.role;
    data['id'] = this.id;
    data['dateAdded'] = this.dateAdded;
    data['dateModified'] = this.dateModified;
    return data;
  }
}