///All EndPoints Go Here
class EndPoints {
String baseUrl = 'https://localhost:7168/';
///////
/////   UPLOAD
  ///////
  String uploadGetAll() {
    String urlUploadsGetAll = '${baseUrl}uploads/get-all';
    return urlUploadsGetAll;
  }

  String uploadGetId() {
    String urlUploadsGetId = '${baseUrl}uploads/get-by-id/{3fa85f64-5717-4562-b3fc-2c963f66afa6}';
    return urlUploadsGetId;
  }

  String uploadUpdate() {
    String urlUploadsUpdate = '${baseUrl}uploads/update}';
    return urlUploadsUpdate;
  }

  String uploadPost() {
    String urlUploadsPost = '${baseUrl}uploads/add-uploads';
    return urlUploadsPost;
  }

  String uploadDelete() {
    String urlUploadsDelete = '${baseUrl}uploads/delete';
    return urlUploadsDelete;
  }
  ///////
/////   INTERN
  ///////
  String internGetAll() {
    String urlInternsGetAll = '${baseUrl}intern/get-all';
    return urlInternsGetAll;
  }

  String internGetId() {
    String urlInternsGetId = '${baseUrl}intern/get-by-id/{d5647f74-1b94-4f27-805c-086349e752d1}';
    return urlInternsGetId;
  }

  String internUpdate() {
    String urlInternsUpdate = '${baseUrl}intern/update/{3fa85f64-5717-4562-b3fc-2c963f66afa6}}';
    return urlInternsUpdate;
  }

  String internPost() {
    String urlInternsPost = '${baseUrl}intern/add-uploads/{3fa85f64-5717-4562-b3fc-2c963f66afa6}';
    return urlInternsPost;
  }

  String internDelete() {
    String urlInternsDelete = '${baseUrl}intern/delete/{3fa85f64-5717-4562-b3fc-2c963f66afa6}';
    return urlInternsDelete;
  }
  ///////
/////   LEARNING MATERIAL
  ///////
  String LearningMaterialGetAll() {
    String urlLeaningMaterialGetAll = '${baseUrl}learning-material/get-all';
    return urlLeaningMaterialGetAll;
  }

  String LearningMaterialGetId() {
    String urlLeaningMaterialGetId = '${baseUrl}learning-material/get-by-id/{d56e4b46-a28d-4755-afbe-f46a1f7c21de}';
    return urlLeaningMaterialGetId;
  }

  String LearningMaterialUpdate() {
    String urlLeaningMaterialUpdate = '${baseUrl}learning-material/update/{d56e4b46-a28d-4755-afbe-f46a1f7c21de}';
    return urlLeaningMaterialUpdate;
  }

  String LearningMaterialPost() {
    String urlLeaningMaterialPost = '${baseUrl}learning-material/add-uploads/{d56e4b46-a28d-4755-afbe-f46a1f7c21de}';
    return urlLeaningMaterialPost;
  }

  String LearningMaterialDelete() {
    String urlLeaningMaterialDelete = '${baseUrl}learning-material/delete/{d56e4b46-a28d-4755-afbe-f46a1f7c21de}';
    return urlLeaningMaterialDelete;
  }

}

