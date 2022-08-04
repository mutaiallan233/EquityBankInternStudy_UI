import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/controller/upload/upload.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/intern_model.dart';
import 'package:intern_study_guide/data/learning_material_model.dart';

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
                Divider(),
            Text('upload'),
            Row(
              children: [
                Text('Anything yet'),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.uploadGetAll();
                      String model = 'upload';

                      List<UploadDetails> uploadDetails =
                          await getUploadDetailsFromApi(url,model);
                      uploadDetails.forEach((element) {
                        print(element.title);
                      });
                    },
                    icon: Icon(Icons.cloud_download)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.uploadGetId();
                      String model = 'upload';
                      UploadDetails uploadDetails =
                          await getUploadDetailsFromApiById(url,model);
                      print(uploadDetails.title);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                      //String url = endpoints.uploadUpdate();

                      makePostRequest();
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.internGetId();
                      String model = 'intern';
                      InternDetails internDetails =
                      await getUploadDetailsFromApiById(url,model);
                    },
                    icon: Icon(Icons.cloud_circle_outlined)),
              ],
            ),
                Divider(),
                Text('Intern'),
                Row(
                  children: [
                    Text('Anything yet'),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.internGetAll();
                          String model = 'intern';

                          List<InternDetails> internDetails =
                          await getUploadDetailsFromApi(url,model);
                          internDetails.forEach((element) {
                            print(element.workEmail);
                          });
                        },
                        icon: Icon(Icons.cloud_download)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.internGetId();
                          String model = 'intern';
                          InternDetails internDetails =
                          await getUploadDetailsFromApiById(url,model);
                          print(internDetails.department);
                        },
                        icon: Icon(Icons.cloud_circle)),
                    IconButton(
                        onPressed: () async {
                          //makePostRequest();
                        },
                        icon: Icon(Icons.cloud_upload)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.internGetId();
                          String model = 'intern';
                          InternDetails internDetails =
                          await getUploadDetailsFromApiById(url,model);
                        },
                        icon: Icon(Icons.cloud_circle_outlined)),
                  ],
                ),
                Divider(),
                Text('Learning Material'),
                Row(
                  children: [
                    Text('Anything yet'),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.learningMaterialGetAll();
                          String model = 'learning';

                          List<LearningMaterialDetails> learningMaterialDetails =
                          await getUploadDetailsFromApi(url,model);
                          learningMaterialDetails.forEach((element) {
                            print(element.isChecked);
                          });
                        },
                        icon: Icon(Icons.cloud_download)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.learningMaterialGetId();
                          String model = 'learning';
                          LearningMaterialDetails learningMaterialDetails =
                          await getUploadDetailsFromApiById(url,model);
                          print(learningMaterialDetails.workEmail);
                        },
                        icon: Icon(Icons.cloud_circle)),
                    IconButton(
                        onPressed: () async {
                          //makePostRequest();
                        },
                        icon: Icon(Icons.cloud_upload)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.internGetId();
                          String model = 'learning';
                          InternDetails internDetails =
                          await getUploadDetailsFromApiById(url,model);
                        },
                        icon: Icon(Icons.cloud_circle_outlined)),
                  ],
                ),
                Divider(),
                Text('Content Creator'),
                Row(
                  children: [
                    Text('Anything yet'),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.contentCreatorGetAll();
                          String model = 'content';

                          List<ContentCreatorDetails> contentCreatorDetails =
                          await getUploadDetailsFromApi(url,model);
                           contentCreatorDetails.forEach((element) {
                            print(element.role);
                          });
                        },
                        icon: Icon(Icons.cloud_download)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.contentCreatorGetId();
                          String model = 'content';
                          ContentCreatorDetails contentCreatorDetails =
                          await getUploadDetailsFromApiById(url,model);
                          print(contentCreatorDetails.role);
                        },
                        icon: Icon(Icons.cloud_circle)),
                    IconButton(
                        onPressed: () async {
                          //makePostRequest();
                        },
                        icon: Icon(Icons.cloud_upload)),
                    IconButton(
                        onPressed: () async {
                          String url = endpoints.internGetId();
                          String model = 'content';
                          InternDetails internDetails =
                          await getUploadDetailsFromApiById(url,model);
                        },
                        icon: Icon(Icons.cloud_circle_outlined)),
                  ],
                ),
          ],
        ),
      )),
    );
  }
}
