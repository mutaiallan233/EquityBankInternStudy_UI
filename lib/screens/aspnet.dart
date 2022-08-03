import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/controller/upload/upload.dart';

import '../data/upload_model.dart';

class Aspnet extends StatefulWidget {
  const Aspnet({Key? key}) : super(key: key);

  @override
  State<Aspnet> createState() => _AspnetState();
}

class _AspnetState extends State<Aspnet> {
  bool isPressed = false;
  String? dioSays = 'null';
  EndPoints endpoints = new EndPoints();
  //String? urlprovided = 'https://localhost:7168/uploads/get-all';
  //EndPoints.uploadGetAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text('Anything yet'),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.uploadGetAll();

                      List<UploadDetails> uploadDetails =
                          await getUploadDetailsFromApi(url);
                      uploadDetails.forEach((element) {
                        print(element.title);
                      });
                    },
                    icon: Icon(Icons.cloud_download)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.uploadGetId();
                      UploadDetails uploadDetails =
                          await getUploadDetailsFromApiById(url);
                      print(uploadDetails.title);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                     makePostRequest();
                    },
                    icon: Icon(Icons.cloud_upload))
              ],
            ),
            isPressed
                ? Text('Dio say\'s: ' + dioSays!)
                : Text('Click on the icon')
          ],
        ),
      )),
    );
  }
}
