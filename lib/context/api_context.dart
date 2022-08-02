///All EndPoints Go Here
class EndPoints {
String baseUrl = 'https://localhost:7168/';
//note upload Api Endpoints
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
}

