import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intern_study_guide/client/generic_service.dart';
import 'package:intern_study_guide/context/api_context.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/intern_model.dart';
import 'package:intern_study_guide/data/learning_material_model.dart';

import '../client/api_client.dart';
import '../client/stream_service.dart';
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

  //Stream Function
  Stream<int> generateNumbers = (() async* {
    await Future<void>.delayed(Duration(seconds: 2));

    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  })();

  Stream<UploadDetails> streamData() async* {
    int i = 0;
    String url = endpoints.uploadGetId();
    String id = '0b655f33-c1ce-4d99-8298-0ed448744c16';
    while ( i < 100){
      UploadDetails uploadDetails =
      await GenericService<UploadDetails>()
          .get(UploadDetails.fromJson, url,id);
      await Future.delayed(Duration(seconds: 2));

          yield uploadDetails;
      }
  }

  Stream<List<UploadDetails>> streamListData() async* {
    int i = 0;
    String url = endpoints.uploadGetAll();
    while ( i < 100 ){
      List<UploadDetails> uploadDetails = await GenericService<UploadDetails>().getAll(UploadDetails.fromJson, url);
      await Future.delayed(Duration(seconds: 2));

      yield uploadDetails;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          child: Column(
            children: [
              Divider(),
              Text('upload'),
              Row(
                children: [
                  Text('Testing Endpoints(5)'),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.uploadGetAll();

                        List<UploadDetails> uploadDetails =
                            await GenericService<UploadDetails>()
                                .getAll(UploadDetails.fromJson, url);
                        uploadDetails.forEach((element) {
                          print(element.title);
                        });
                      },
                      icon: Icon(Icons.cloud_download)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.uploadGetId();
                        String id = '3fa85f64-5717-4562-b3fc-2c963f66afa6';

                        UploadDetails uploadDetails =
                            await GenericService<UploadDetails>()
                                .get(UploadDetails.fromJson, url, id);
                        print(uploadDetails.title);
                      },
                      icon: Icon(Icons.cloud_circle)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.uploadPost();
                        print(url);
                        UploadDetails uploadDetails =
                            await GenericService<UploadDetails>().create(
                                url,
                                UploadDetails(
                                    title: 'CI/CD',
                                    department: 'DevOp tools',
                                    content: 'Classes and Constructors',
                                    summary:
                                        'Injecting interfaces into classes and functions like a pro',
                                    duration: 6,
                                    contentCreatorId:
                                        "68e42439-b4c9-413c-b33c-f25cfb444e72"));
                        //dio.post(url, body);
                      },
                      icon: Icon(Icons.cloud_upload)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.uploadUpdate();
                        String id = '54ba229d-e83f-4f9f-a559-212ce00a8ab0';

                        UploadDetails uploadDetails =
                            await GenericService<UploadDetails>().update(
                                UploadDetails(
                                    title: "Microservices",
                                    department: '',
                                    content: '',
                                    summary: '',
                                    duration: 5,
                                    contentCreatorId:
                                        '68e42439-b4c9-413c-b33c-f25cfb444e72'),
                                url,
                                id);
                        print(url);
                      },
                      icon: Icon(Icons.cloud_circle_outlined)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.uploadDelete();
                        String id = '8ad70770-ba98-4dc7-bf9b-3aab8f4e9e24';
                        print(url);
                        Future<bool> uploadDetails =
                            GenericService<UploadDetails>().delete(id, url);
                      },
                      icon: Icon(Icons.delete_forever_outlined)),
                ],
              ),
              Divider(),
              Text('Intern'),
              Row(
                children: [
                  Text('Testing Endpoints(5)'),
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
                        InternDetails internDetails =
                            await getDetailsFromApiById(url, model);
                        String urlAccess =
                            endpoints.internUpdate() + '${internDetails.id}';
                        print(urlAccess);
                        makePatchRequest(
                            urlAccess, InternDetails(pfNumber: '777777'));
                      },
                      icon: Icon(Icons.cloud_circle_outlined)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.internDelete() +
                            '${'d5647f74-1b94-4f27-805c-086349e752d1'}';
                        print(url);
                        makeDeleteRequest(url);
                      },
                      icon: Icon(Icons.delete_forever_outlined)),
                ],
              ),
              Divider(),
              Text('Learning Material'),
              Row(
                children: [
                  Text('Testing Endpoints(5)'),
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
                        LearningMaterialDetails learningMaterialDetails =
                            await getDetailsFromApiById(url, model);
                        String urlAccess = endpoints.learningMaterialUpdate() +
                            '${learningMaterialDetails.id}';
                        print(urlAccess);
                        makePatchRequest(
                            urlAccess,
                            LearningMaterialDetails(
                                uploadModelId:
                                    learningMaterialDetails.uploadModelId,
                                internId: learningMaterialDetails.internId,
                                isChecked: false));
                      },
                      icon: Icon(Icons.cloud_circle_outlined)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.learningMaterialDelete() +
                            '${'cc693de6-6116-42df-a090-81ab6e4f876e'}';
                        print(url);
                        makeDeleteRequest(url);
                      },
                      icon: Icon(Icons.delete_forever_outlined)),
                ],
              ),
              Divider(),
              Text('Content Creator'),
              Row(
                children: [
                  Text('Testing Endpoints(5)'),
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
                        String url = endpoints.contentCreatorGetId();
                        String model = 'content';
                        ContentCreatorDetails contentCreatorDetails =
                            await getDetailsFromApiById(url, model);
                        String urlAccess = endpoints.contentCreatorUpdate() +
                            '${contentCreatorDetails.id}';
                        print(urlAccess);
                        makePatchRequest(urlAccess,
                            ContentCreatorDetails(role: 'Lead backend dev'));
                      },
                      icon: Icon(Icons.cloud_circle_outlined)),
                  IconButton(
                      onPressed: () async {
                        String url = endpoints.contentCreatorDelete() +
                            '${'8db153f8-05bf-4f59-837a-323622e55fee'}';
                        print(url);
                        makeDeleteRequest(url);
                      },
                      icon: Icon(Icons.delete_forever_outlined)),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('back')),
              StreamBuilder<int>(
                //initialData: 0,
                stream: generateNumbers,
                builder: (
                    BuildContext context,
                    AsyncSnapshot<int> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(color: Colors.red, fontSize: 40)
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              Divider(),
              StreamBuilder<UploadDetails>(
                //initialData: 0,
                stream: streamData(),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<UploadDetails> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Text(
                          snapshot.data!.title.toString(),
                          style: const TextStyle(color: Colors.red, fontSize: 40)
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              Divider(),
              StreamBuilder<List<UploadDetails>>(
                //initialData: 0,
                stream: streamListData(),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<List<UploadDetails>> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.map((e) => new Text(e.title.toString())).toList(),
                      );
                      /*return Text(
                          snapshot.data!.forEach((element) { }),
                          style: const TextStyle(color: Colors.red, fontSize: 40)
                      );*/
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              Divider(),
              StreamBuilder<UploadDetails>(
                //initialData: 0,
                stream: StreamService<UploadDetails>().streamData(UploadDetails.fromJson, endpoints.uploadGetId(), '0b655f33-c1ce-4d99-8298-0ed448744c16'),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<UploadDetails> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Text(
                          snapshot.data!.title.toString(),
                          style: const TextStyle(color: Colors.red, fontSize: 40)
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              Divider(),
              StreamBuilder<List<UploadDetails>>(
                //initialData: 0,
                stream: StreamService<UploadDetails>().streamListData(UploadDetails.fromJson, endpoints.uploadGetAll()),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<List<UploadDetails>> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.map((e) => new Text(e.title.toString())).toList(),
                      );
                      /*return Text(
                          snapshot.data!.forEach((element) { }),
                          style: const TextStyle(color: Colors.red, fontSize: 40)
                      );*/
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
