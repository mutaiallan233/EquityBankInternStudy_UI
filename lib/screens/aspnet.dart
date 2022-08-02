import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Aspnet extends StatefulWidget {
  const Aspnet({Key? key}) : super(key: key);

  @override
  State<Aspnet> createState() => _AspnetState();
}

class _AspnetState extends State<Aspnet> {

  void getHttp() async {
    try {

      Response responseInterns;
      Response responseUploads;
      var dio = Dio();
      responseInterns = await dio.get('https://localhost:7168/intern/get-all');
      responseUploads = await dio.get('https://localhost:7168/uploads/get-all');

      String answer = responseInterns.data.toString();
      print(responseInterns.data[0]['workEmail']);
      //var data = json.decode(responseInterns.data);
      //UploadDetails sample = sampleFromJson(responseInterns.data);
     // var res = data[] as List;
      //print('RESPONSE IS: $sample');
      //UploadDetails uploadDetails = UploadDetails.fromJson(jsonDecode(responseUploads.data[0]));
      //List<UploadDetails> uploadDetails = await ReadJsonData(responseInterns.data);

      //var data = json.decode(responseUploads.data[0]).cast<UploadDetails>();
      //print(data);
      //print(responseUploads.data[0]['title']);
      //print('Story yako: ${uploadDetails.title}');
      //print(uploadDetails);

    } catch (e) {
      print(e);
    }
  }

  bool isPressed = false;
  String? dioSays = 'null';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text('Anything yet'),
                IconButton(onPressed: (){
                  getHttp();
                },
                    icon: Icon(Icons.cloud_download))
              ],
            ),
            isPressed?Text('Dio say\'s: ' + dioSays!):Text('Click on the icon')
          ],
        ),
      )),
    );
  }
}
