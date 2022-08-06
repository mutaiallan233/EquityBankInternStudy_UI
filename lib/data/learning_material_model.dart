class LearningMaterialDetails {
  String? uploadModelId;
  String? internId;
  String? workEmail;
  bool? isChecked;
  String? id;
  String? dateAdded;
  String? dateModified;

  LearningMaterialDetails(
      {this.uploadModelId,
        this.internId,
        this.workEmail,
        this.isChecked,
        this.id,
        this.dateAdded,
        this.dateModified});

  LearningMaterialDetails.fromJson(Map<String, dynamic> json) {
    uploadModelId = json['uploadModelId'];
    internId = json['internId'];
    workEmail = json['workEmail'];
    isChecked = json['isChecked'];
    id = json['id'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadModelId'] = this.uploadModelId;
    data['internId'] = this.internId;
    data['workEmail'] = this.workEmail;
    data['isChecked'] = this.isChecked;
    //data['id'] = this.id;
    //data['dateAdded'] = this.dateAdded;
    //data['dateModified'] = this.dateModified;
    return data;
  }
}