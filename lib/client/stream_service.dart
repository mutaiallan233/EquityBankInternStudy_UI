import 'package:intern_study_guide/client/api_client.dart';
import 'package:intern_study_guide/client/generic_service.dart';

class StreamService<T> {

  Stream<T> streamData(T Function(Map<String, dynamic>) fromJson, String url, String id) async* {
    int i = 0;

    while ( i < 100){
      T streamDetails =
      await GenericService<T>()
          .get(fromJson, url,id);
      await Future.delayed(Duration(seconds: 2));

      yield streamDetails;
    }
  }

  Stream<List<T>> streamListData(T Function(Map<String, dynamic>) fromJson, String url) async* {
    int i = 0;

    while (i < 10) {
      List<T> streamDetails = await GenericService<T>().getAll(fromJson, url);
      await Future.delayed(Duration(seconds: 2));

      yield streamDetails;
    }
  }
}