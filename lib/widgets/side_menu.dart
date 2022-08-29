import 'package:flutter/material.dart';
import 'package:intern_study_guide/screens/register_intern.dart';
import 'package:intern_study_guide/widgets/dialogs/detail_bottomsheet.dart';
import 'package:intern_study_guide/widgets/dialogs/progress_dialog.dart';
import 'package:intern_study_guide/widgets/study_progress.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/data.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  _chartModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.black.withOpacity(.3),
            child: new Center(
              //child: new Text("Modal BottomSheet",textScaleFactor: 2,
              //style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              child: BarChartSample1(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 280.0,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/equity_logo.png',
                  height: 55.0,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
          _SideMenuIconTab(
            iconData: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pushNamed(context, '/aspnet');
            },
          ),
          _SideMenuIconTab(
            iconData: Icons.search,
            title: 'Search',
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ProgressDialog();
                  });
            },
          ),
          _SideMenuIconTab(
            iconData: Icons.area_chart,
            title: 'Progress',
            onTap: () {
              /* showDialog(
                  context: context,
                  builder: (context){
                    return ProgressDialog();
                  });*/
              return _chartModalSheet();
              ProgressDialog();
            },
          ),
          const SizedBox(height: 12.0),
          _LibraryPlaylists(),
        ],
      ),
    );
  }
}

class _SideMenuIconTab extends StatefulWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  const _SideMenuIconTab({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_SideMenuIconTab> createState() => _SideMenuIconTabState();
}

class _SideMenuIconTabState extends State<_SideMenuIconTab> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.iconData,
        color: Theme.of(context).iconTheme.color,
        size: 28.0,
      ),
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: widget.onTap,
    );
  }
}

class _LibraryPlaylists extends StatefulWidget {
  @override
  __LibraryPlaylistsState createState() => __LibraryPlaylistsState();
}

class __LibraryPlaylistsState extends State<_LibraryPlaylists> {
  ScrollController? _scrollController;

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

  //bottom sheet
  _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.black.withOpacity(.3),
            child: new Center(
              //child: new Text("Modal BottomSheet",textScaleFactor: 2,
              //style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              child: BarChartSample1(),
            ),
          );
        });
  }

  //calendar bottom sheet
  _showCalendarSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            //height: MediaQuery.of(context).size.height / 2,
            color: Colors.black.withOpacity(.3),
            child: new Center(
              //child: new Text("Modal BottomSheet",textScaleFactor: 2,
              //style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(1960, DateTime.january, 1),
                  lastDay: DateTime.utc(2030, DateTime.december,31),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          physics: const ClampingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'YOUR LIBRARY',
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...yourLibrary
                    .map((e) => ListTile(
                          dense: true,
                          title: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {},
                        ))
                    .toList(),
              ],
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'PLAYLISTS',
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...playlists
                    .map((e) => ListTile(
                          dense: true,
                          title: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            if (e == 'Today\'s Content') {
                              return _showModalSheet();
                            }
                            if (e == 'Calender') {
                              return _showCalendarSheet();
                              //print(DateTime.now());
                            }
                            if (e == 'Tools') {
                              return _showModalSheet();
                            }
                          },

                          ///TODO:::USE TECHNIQUES FROM THE DIALOG BOX TO HAVE SEPARATE BOTTOM SHEET AND PASS VALUES TO IT BY USE OF SIDE MENU+
                        ))
                    .toList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
