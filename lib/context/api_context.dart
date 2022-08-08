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
    String urlUploadsUpdate = '${baseUrl}uploads/update/';
    return urlUploadsUpdate;
  }

  String uploadPost() {
    String urlUploadsPost = '${baseUrl}uploads/add-uploads';
    return urlUploadsPost;
  }

  String uploadDelete() {
    String urlUploadsDelete = '${baseUrl}uploads/delete/';
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
    String urlInternsGetId = '${baseUrl}intern/get-by-id/d5647f74-1b94-4f27-805c-086349e752d1';
    return urlInternsGetId;
  }

  String internUpdate() {
    String urlInternsUpdate = '${baseUrl}intern/update/';
    return urlInternsUpdate;
  }

  String internPost() {
    String urlInternsPost = '${baseUrl}intern/add-intern';
    return urlInternsPost;
  }

  String internDelete() {
    String urlInternsDelete = '${baseUrl}intern/delete/';
    return urlInternsDelete;
  }
  ///////
/////   LEARNING MATERIAL
  ///////
  String learningMaterialGetAll() {
    String urlLeaningMaterialGetAll = '${baseUrl}learning-material/get-all';
    return urlLeaningMaterialGetAll;
  }

  String learningMaterialGetId() {
    String urlLeaningMaterialGetId = '${baseUrl}learning-material/get-by-id/d56e4b46-a28d-4755-afbe-f46a1f7c21de';
    return urlLeaningMaterialGetId;
  }

  String learningMaterialUpdate() {
    String urlLeaningMaterialUpdate = '${baseUrl}learning-material/update/';
    return urlLeaningMaterialUpdate;
  }

  String learningMaterialPost() {
    String urlLeaningMaterialPost = '${baseUrl}learning-material/add-learning-material';
    return urlLeaningMaterialPost;
  }

  String learningMaterialDelete() {
    String urlLeaningMaterialDelete = '${baseUrl}learning-material/delete/';
    return urlLeaningMaterialDelete;
  }

  ///////
/////   CONTENT CREATOR
  ///////
  String contentCreatorGetAll() {
    String urlLeaningMaterialGetAll = '${baseUrl}content-creator/get-all';
    return urlLeaningMaterialGetAll;
  }

  String contentCreatorGetId() {
    String urlLeaningMaterialGetId = '${baseUrl}content-creator/get-by-id/8db153f8-05bf-4f59-837a-323622e55fee';
    return urlLeaningMaterialGetId;
  }

  String contentCreatorUpdate() {
    String urlLeaningMaterialUpdate = '${baseUrl}content-creator/update/';
    return urlLeaningMaterialUpdate;
  }

  String contentCreatorPost() {
    String urlLeaningMaterialPost = '${baseUrl}content-creator/add-creator';
    return urlLeaningMaterialPost;
  }

  String contentCreatorDelete() {
    String urlLeaningMaterialDelete = '${baseUrl}content-creator/delete/';
    return urlLeaningMaterialDelete;
  }

}

