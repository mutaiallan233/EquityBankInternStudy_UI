import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intern_study_guide/data/departments.dart';
import 'package:intern_study_guide/data/durations.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../client/generic_service.dart';
import '../client/api_client.dart';
import '../client/stream_service.dart';
import '../data/content_creator_model.dart';
import '../data/data.dart';
import '../data/intern_model.dart';
import '../data/upload_model.dart';
import '';

class PlaylistHeader extends StatefulWidget {
  final Playlist playlist;

  PlaylistHeader({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  State<PlaylistHeader> createState() => _PlaylistHeaderState();
}

class _PlaylistHeaderState extends State<PlaylistHeader> {
  var stream1 = StreamService<InternDetails>().streamData(
      InternDetails.fromJson,
      endpoints.internGetId(),
      '148eaa64-71ca-477a-8e74-299473dccde0');
  var stream2 = StreamService<UploadDetails>().streamData(
      UploadDetails.fromJson,
      endpoints.uploadGetId(),
      '859ed698-9b4f-4dd1-bdf6-dac690fd32eb');
  var stream3 = StreamService<ContentCreatorDetails>().streamData(
      ContentCreatorDetails.fromJson,
      endpoints.contentCreatorGetId(),
      '096c060d-0906-434c-8440-e23b8be90c6f');

  @override
  Widget build(BuildContext context) {
    String url = endpoints.internGetId();
    String id = '932c13da-6cec-44bf-89c6-960692d0d611';

    return StreamBuilder3<InternDetails, UploadDetails, ContentCreatorDetails>(
      streams: StreamTuple3(stream1, stream2, stream3),
      initialData: InitialDataTuple3(
        InternDetails(
          pfNumber: 'loading',
          workEmail: 'loading',
          department: 'loading',
        ),
        UploadDetails(
            title: 'loading',
            department: 'loading',
            content: ['loading'],
            summary: 'loading',
            contentCreatorName: 'loading',
            duration: 0),
        ContentCreatorDetails(
            workEmail: 'loading', department: 'loading', role: 'loading'),
      ),
      builder: (
        context,
        snapshots,
      ) {
        if (snapshots.snapshot1.connectionState == ConnectionState.waiting ||
            snapshots.snapshot2.connectionState == ConnectionState.waiting ||
            snapshots.snapshot3.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Visibility(
                visible: snapshots.snapshot1.hasData &&
                    snapshots.snapshot3.hasData &&
                    snapshots.snapshot3.hasData,
                child: Text(
                  snapshots.snapshot2.data.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ],
          );
        } else if (snapshots.snapshot1.connectionState ==
                    ConnectionState.active &&
                snapshots.snapshot2.connectionState == ConnectionState.active &&
                snapshots.snapshot3.connectionState == ConnectionState.active ||
            snapshots.snapshot1.connectionState == ConnectionState.done &&
                snapshots.snapshot2.connectionState == ConnectionState.done &&
                snapshots.snapshot1.connectionState == ConnectionState.done) {
          if (snapshots.snapshot1.hasError ||
              snapshots.snapshot2.hasError ||
              snapshots.snapshot3.hasError) {
            return const Text('Error');
          } else if (snapshots.snapshot1.hasData &&
              snapshots.snapshot2.hasData &&
              snapshots.snapshot3.hasData) {
            return Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      widget.playlist.imageURL,
                      height: 200.0,
                      width: 200.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DEPARTMENT',
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(fontSize: 12.0),
                          ),
                          const SizedBox(height: 12.0),
                          Text(snapshots.snapshot2.data!.department.toString(),
                              style: Theme.of(context).textTheme.headline2),
                          const SizedBox(height: 16.0),
                          Text(
                            widget.playlist.description,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Created by ${snapshots.snapshot3.data!.workEmail} • ${widget.playlist.songs.length} topics, ${widget.playlist.duration}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                _PlaylistButtons(followers: widget.playlist.followers),
              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text(
              'State: ${snapshots.snapshot1.connectionState} <-> ${snapshots.snapshot2.connectionState} <-> ${snapshots.snapshot3.connectionState}');
        }
      },
    );
  }
}

class _PlaylistButtons extends StatefulWidget {
  final String followers;

  const _PlaylistButtons({
    Key? key,
    required this.followers,
  }) : super(key: key);

  @override
  State<_PlaylistButtons> createState() => _PlaylistButtonsState();
}

class _PlaylistButtonsState extends State<_PlaylistButtons> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  TextEditingController _summaryController = new TextEditingController();
  Departments deps = new Departments();
  Period period = new Period();
  List<String> tags = ['tagA', 'tagB', 'tagC'];

  createContent() async {
    String url = endpoints.uploadPost();
    String jsonTags = jsonEncode(tags);
    //print(jsonTags);
    UploadDetails uploadDetails = await GenericService<UploadDetails>().create(
        url,
        UploadDetails(
            title: '',
            department: '',
            content: [''],
            summary: '',
            duration: 0,
            contentCreatorName: ''));
  }

  @override
  Widget build(BuildContext context) {
    String dropValue = deps.dropValue;
    int durValue = period.intValue;

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              return Container(
                //height: 200.0,
                color: Colors.black12,
                child: new Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                labelText: 'Creator Name',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: _summaryController,
                            decoration: const InputDecoration(
                                labelText: 'Summary',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                          ),
                          TextFormField(
                            controller: _contentController,
                            decoration: const InputDecoration(
                                labelText: 'Content',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                          ),
                          DropdownButton(
                              value: dropValue,
                              icon: Icon(Icons.arrow_drop_down_circle_outlined),
                              isExpanded: true,
                              /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),*/
                              items: deps.departments.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropValue = newValue!;
                                  print('The new value is: ' + dropValue);
                                });
                              }),
                          DropdownButton(
                              value: durValue,
                              icon: Icon(Icons.arrow_drop_down_circle_outlined),
                              isExpanded: true,
                              /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),*/
                              items: period.durations.map((int items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.toString()),
                                );
                              }).toList(),
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              onChanged: (int? newValue) {
                                setState(() {
                                  durValue = newValue!;
                                  print('The new value is: ' +
                                      durValue.toString());
                                });
                              }),
                          ElevatedButton(
                              onPressed: () {
                                createContent();
                              },
                              child: Text('data')),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          });
    }

    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 48.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            primary: Theme.of(context).iconTheme.color,
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontSize: 12.0, letterSpacing: 2.0),
          ),
          onPressed: () async {
            //_showModalSheet();
            await showDialog(
                context: context,
                builder: (context) {
                  return ContentDialog(myTitle: 'supervisor');
                });
          },
          child: const Text('ADD NEW'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: const Icon(Icons.laptop_chromebook_outlined),
          iconSize: 30.0,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          iconSize: 30.0,
          onPressed: () {},
        ),
        const Spacer(),
        Text(
          'Interns \04',
          style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}

class ContentDialog extends StatefulWidget {
  String? myTitle;
  ContentDialog({Key? key, this.myTitle}) : super(key: key);

  @override
  State<ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _contentController = new TextEditingController();
    TextEditingController _summaryController = new TextEditingController();
    Departments deps = new Departments();
    Period period = new Period();

    String dropValue = deps.dropValue;
    int durValue = period.intValue;

    //var selected = this.selected;
showScaffold() async {
  final snackBar = await SnackBar(
    content: const Text('SuccessFul'),
    backgroundColor: (Colors.white54),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



    print(widget.myTitle);
    switch (widget.myTitle) {
      case 'supervisor':
        {
          // statements;
          return StatefulBuilder(builder: (builder, setState) {
            return SimpleDialog(
              title: Row(
                children: [
                  Icon(Icons.person_add_alt_outlined),
                  SizedBox(
                    width: 13,
                  ),
                  Text("Upload My Content"),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Divider(),
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Allan Mutai',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: _titleController,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.book_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Programming Skills',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Topic',
                        ),
                      ),
                      TextFormField(
                        controller: _summaryController,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.device_thermostat,
                            color: Colors.grey,
                          ),
                          hintText: 'Getting you started as a Dev',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Summary',
                        ),
                      ),
                      TextFormField(
                        controller: _contentController,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.link,
                            color: Colors.grey,
                          ),
                          hintText: 'A link to the relevant Study',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Study Material',
                        ),
                      ),
                      DropdownButton(
                          value: dropValue,
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          isExpanded: true,
                          /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),*/
                          items: deps.departments.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropValue = newValue!;
                              print('The new value is: ' + dropValue);
                            });
                          }),
                      DropdownButton(
                          value: durValue,
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          isExpanded: true,
                          /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),*/
                          items: period.durations.map((int items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              durValue = newValue!;
                              print('The new value is: ' + durValue.toString());
                            });
                          }),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        VerticalDivider(
                          color: Colors.white, //color of divider
                          //width: 10, //width space of divider
                          //thickness: 3, //thickness of divier line
                          // indent: 10, //Spacing at the top of divider.
                          // endIndent: 10,
                        ),
                        IconButton(
                            onPressed: () async {
                              String url = endpoints.uploadPost();
                              UploadDetails uploadDetails =
                                  await GenericService<UploadDetails>().create(
                                      url,
                                      UploadDetails(
                                          title: _titleController.text,
                                          department: dropValue,
                                          content: [_contentController.text],
                                          summary: _summaryController.text,
                                          duration: durValue,
                                          contentCreatorName: _nameController.text,
                                        contentCreatorId: "096c060d-0906-434c-8440-e23b8be90c6f",
                                      ));
                              Navigator.of(context).pop();
                              await showScaffold();
                            },
                            icon: Icon(Icons.done_all))
                      ],
                    ),
                  ),
                )
              ],
            );
          });
        }

      case 'intern':
        {
          //statements;
          return StatefulBuilder(builder: (builder, setState) {
            return SimpleDialog(
              title: Row(
                children: [
                  Icon(Icons.person_add_alt_outlined),
                  SizedBox(
                    width: 13,
                  ),
                  Text("Upload Learning Content"),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Divider(),
                      /* TextFormField(
                        controller: _pfnumber,
                        style: TextStyle(
                          // decoration: InputDecoration(),
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'pfnumber',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Staff Number',
                        ),
                      ),*/
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Allan Mutai',
                        ),
                      ),
                      DropdownButton(
                          value: dropValue,
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          isExpanded: true,
                          /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),*/
                          items: deps.departments.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropValue = newValue!;
                              print('The new value is: ' + dropValue);
                            });
                          }),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        VerticalDivider(
                          color: Colors.white, //color of divider
                          //width: 10, //width space of divider
                          //thickness: 3, //thickness of divier line
                          // indent: 10, //Spacing at the top of divider.
                          // endIndent: 10,
                        ),
                        IconButton(
                            onPressed: () async {
                              String url = endpoints.contentCreatorPost();
                              /* ContentCreatorDetails contentCreatorDetails =
                          await GenericService<ContentCreatorDetails>().create(
                              url,
                              ContentCreatorDetails(workEmail: _workemail.text,department: dropValue,role: 'supervisor'));
                          //Navigator.of(context).pop();*/
                            },
                            icon: Icon(Icons.done_all))
                      ],
                    ),
                  ),
                )
              ],
            );
          });
        }

      default:
        {
          //statements;
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('An error occured'),
          );
        }
    }
  }
}
