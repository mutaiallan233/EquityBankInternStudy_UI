import 'package:flutter/material.dart';
import 'package:intern_study_guide/widgets/register_dialog.dart';

import '../data/data.dart';
import '../widgets/study_header.dart';
import '../widgets/tracks_list.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollController;
  TextEditingController _myTitle = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 140.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_left, size: 28.0),
                ),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_right, size: 28.0),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              bool readonly = true;

              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return SimpleDialog(
                        title: Text("Register to The Intern Study Guide"),
                        children: <Widget>[
                          Divider(),
                          SimpleDialogOption(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await showDialog(
                                  context: context,
                                  builder: (context){
                                return RegisterDialog(selected: 'intern');
                              });
                            },
                            child: const Text('Am an Intern'),
                          ),
                          SimpleDialogOption(
                            onPressed: () async {
                              Navigator.of(context).pop();
                             await showDialog(
                                  context: context,
                                  builder: (context){
                                    return RegisterDialog(selected: 'supervisor');
                                  });
                            },
                            child: const Text('Am a supervisor'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              if (readonly) {
                                setState(() {
                                  readonly = false;
                                });
                              } else {
                                setState(() {
                                  readonly = true;
                                });
                              }
                            },
                            child: readonly
                                ? Row(children: [
                                    Text('Any other'),
                                    Icon(Icons.keyboard_arrow_down)
                                  ])
                                : Row(
                                    children: [
                                      Text('Non other'),
                                      Icon(Icons.keyboard_arrow_up)
                                    ],
                                  ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:4,
                                  child: TextFormField(
                                    controller: _myTitle,
                                    readOnly: readonly,
                                    decoration: readonly
                                        ? InputDecoration(
                                            fillColor:
                                                Colors.orange.withOpacity(.0),
                                            filled: true)
                                        : InputDecoration(
                                            fillColor:
                                            Theme.of(context).colorScheme.secondary.withOpacity(.3),
                                            filled: true,
                                            hintText: 'Your Title Goes Here',
                                          ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: readonly
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.grey,
                                          ))
                                      : IconButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            print(_myTitle.text);
                                            await showDialog(
                                                context: context,
                                                builder: (context){
                                              return RegisterDialog(selected: 'another', myTitle: _myTitle.text);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            color:
                                                Theme.of(context).colorScheme.secondary,
                                          )),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                  });
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30.0,
            ),
            label: const Text('Allan Mutai'),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.keyboard_arrow_down, size: 30.0),
            onPressed: () {},
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFAF1018),
              Theme.of(context).backgroundColor,
            ],
            stops: const [0, 0.3],
          ),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 60.0,
            ),
            children: [
              PlaylistHeader(playlist: widget.playlist),
              TracksList(tracks: widget.playlist.songs),
            ],
          ),
        ),
      ),
    );
  }
}
