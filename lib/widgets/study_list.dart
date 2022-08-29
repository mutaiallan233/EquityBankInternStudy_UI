import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../client/api_client.dart';
import '../client/stream_service.dart';
import '../data/upload_model.dart';

class StudyList extends StatefulWidget {
  const StudyList({Key? key}) : super(key: key);

  @override
  State<StudyList> createState() => _StudyListState();
}

class _StudyListState extends State<StudyList> {
  _showModalSheet(String title, int duration, String summary, String name, List<dynamic> content) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            //height: MediaQuery.of(context).size.height / 2,
            color: Colors.black.withOpacity(.3),
            child: new Center(
              //child: new Text("Modal BottomSheet",textScaleFactor: 2,
              //style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              child: Card(
                elevation: 50,
                shadowColor: Colors.red[900],
                color: Colors.black12,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  //height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://pbs.twimg.com/media/EF5dhmJWoAI_sJb?format=jpg&name=medium"), //NetworkImage
                            radius: 67,
                          ), //CircleAvatar
                        ), //CircleAvatar
                        const SizedBox(
                          height: 10,
                        ), //SizedBox
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        ), //Text
                        const SizedBox(
                          height: 10,
                        ), //SizedBox
                         Text(
                          summary,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ), //Textstyle
                        ), //Text
                        const SizedBox(
                          height: 10,
                        ), //SizedBox
                        Text(
                          'Estimated Period ${duration} day(s)',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ), //Textstyle
                        ), //Text
                        Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: content.map((e) => ListTile(
                            title: InkWell(
                                child: Text( e,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              onTap: () async{
                                  launchUrl(Uri.parse(e));
                              },
                            ),
                          )).toList(),
                        ),
                        Divider(),
                        const SizedBox(
                          height: 10,
                        ),//SizedBox
                        SizedBox(
                          width: 150,

                          child: ElevatedButton(
                            onPressed: () => 'Null',
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.lightBlue)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('Complete')
                                ],
                              ),
                            ),
                          ),

                          // ), //RaisedButton
                        ) //SizedBox
                      ],
                    ), //Column
                  ), //Padding
                ), //SizedBox
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UploadDetails>>(
      //initialData: 0,
      stream: StreamService<UploadDetails>()
          .streamListData(UploadDetails.fromJson, endpoints.uploadGetAll()),
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
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return Column(
              children: snapshot.data!
                  .map((e) => GestureDetector(
                        onTap: () {
                          print('tapped: ' + e.title!);
                          _showModalSheet(e.title!, e.duration, e.summary!, e.contentCreatorName!,e.content!);
                        },
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red[50],
                              child: Icon(Icons.book_outlined),
                            ),
                            title: Text(e.title!),
                            subtitle: Text(e.contentCreatorName!),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.red[50],
                              child: Text(e.duration.toString()),
                            ),
                          ),
                          color: Colors.black12,
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
