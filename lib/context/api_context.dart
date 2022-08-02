///All EndPoints Go Here
class EndPoints {
String baseUrl = 'https://localhost:7168/';
//note upload Api Endpoints
  String uploadGetAll() {
    String urlUploadsGetAll = '${baseUrl}uploads/get-all';
    return urlUploadsGetAll;
  }

  String uploadGetId() {
    String urlUploadsGetId = '${baseUrl}uploads/get-by-id/{id here}';
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

