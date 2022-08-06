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
                          await getUploadDetailsFromApi(url, model);
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
                          await getDetailsFromApiById(url, model);
                      print(uploadDetails.title);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.uploadPost();
                      makePostRequest(
                          url,
                          UploadDetails(
                              title: 'Dependency Injection',
                              department: 'programing tools',
                              content: 'Classes and Constructors',
                              summary:
                                  'Injecting interfaces into classes and functions like a pro',
                              duration: 6,
                              contentCreatorId:
                                  "68e42439-b4c9-413c-b33c-f25cfb444e72"
                          )
                      );
                      //dio.post(url, body);
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                    onPressed: () async {
                      ///TODO; THIS CAN BE DONE BETTER BY PARSING ID FROM GETBYID ENDPOINT INSTEAD OF ACCESSING BOTH ENDPOINTS ACTUALLY LET ME DO IT
                      ///TODO: IT WORKS JUST FINE,, UNNECESSARY THOUGH IN THE EVENT A PROVIDER IS GIVING US THE ID
                      ///TODO: AN ERROR ON ASPNET MITIGATED BY PARSING CONTENTCREATORID ON DART TO BE ADDRESSED[BACKEND]
                      ///TODO: LET US PATCH THE REST
                      String urlChange = endpoints.uploadGetId();
                      String model = 'upload';
                      // ContentCreatorDetails contentCreatorDetails =
                      //await getUploadDetailsFromApiById(url, model);
                      UploadDetails uploadDetails = await  getDetailsFromApiById(urlChange, model);
                      String url = endpoints.uploadUpdate()+'${uploadDetails.id}';
                      print(url);
                      await makePatchRequest(url,UploadDetails(title:"Operators of CRUD", department: '', content:'' , summary:'' , duration:5, contentCreatorId:uploadDetails.contentCreatorId));
                    },
                    icon: Icon(Icons.cloud_circle_outlined)),
                IconButton(
                    onPressed: () async {

                    },
                    icon: Icon(Icons.delete_forever_outlined)),
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
                          await getUploadDetailsFromApi(url, model);
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
                          await getDetailsFromApiById(url, model);
                      print(internDetails.department);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.internPost();
                      makePostRequest(
                          url,
                          InternDetails(
                              pfNumber: "67367",
                              workEmail: "njuguna.kipuff@equitybank.co.ke",
                              department: "FrontEnd dev"));
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.internGetId();
                      String model = 'intern';
                      InternDetails internDetails = await getDetailsFromApiById(url, model);
                      String urlAccess = endpoints.internUpdate()+'${internDetails.id}';
                      print(urlAccess);
                      makePatchRequest(urlAccess, InternDetails(pfNumber:'777777'));
                    },
                    icon: Icon(Icons.cloud_circle_outlined)),
                IconButton(
                    onPressed: () async {

                    },
                    icon: Icon(Icons.delete_forever_outlined)),
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
                          await getUploadDetailsFromApi(url, model);
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
                          await getDetailsFromApiById(url, model);
                      print(learningMaterialDetails.workEmail);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.learningMaterialPost();

                      await makePostRequest(
                          url,
                          LearningMaterialDetails(
                              uploadModelId:
                                  "0b655f33-c1ce-4d99-8298-0ed448744c16",
                              internId: "5a788493-1422-40f9-9363-76f5998bf2d5",
                              workEmail: "michael.nganga@equitybank.co.ke",
                              isChecked: false));
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.learningMaterialGetId();
                      String model = 'learning';
                      LearningMaterialDetails learningMaterialDetails = await getDetailsFromApiById(url, model);
                      String urlAccess = endpoints.learningMaterialUpdate()+'${learningMaterialDetails.id}';
                      print(urlAccess);
                      makePatchRequest(urlAccess, LearningMaterialDetails(isChecked: true));
                      ///TODO: RESUME ON POSTMAN TEST FOR PATCH LEARNING MATERIAL,AT CHECKED VALUE
                      ///TODO: I THINK I NEED TO ACCESS THE INTERN FK AND UPLOAD MODEL ID AND WORKEMAIL OF SIJUI NANI
                    },
                    icon: Icon(Icons.cloud_circle_outlined)),
                IconButton(
                    onPressed: () async {

                    },
                    icon: Icon(Icons.delete_forever_outlined)),
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
                          await getUploadDetailsFromApi(url, model);
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
                          await getDetailsFromApiById(url, model);
                      print(contentCreatorDetails.role);
                    },
                    icon: Icon(Icons.cloud_circle)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.contentCreatorPost();

                      await makePostRequest(
                          url,
                          ContentCreatorDetails(
                              workEmail: "david.mtundi@equitybank.co.ke",
                              department: "Solution Development",
                              role: "Creator and Editor"));
                    },
                    icon: Icon(Icons.cloud_upload)),
                IconButton(
                    onPressed: () async {
                      String url = endpoints.internGetId();
                      String model = 'content';
                      InternDetails internDetails =
                          await getDetailsFromApiById(url, model);
                    },
                    icon: Icon(Icons.cloud_circle_outlined)),
                IconButton(
                    onPressed: () async {

                    },
                    icon: Icon(Icons.delete_forever_outlined)),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
