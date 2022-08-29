import 'package:flutter/material.dart';
import 'package:intern_study_guide/client/generic_service.dart';
import 'package:intern_study_guide/client/api_client.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:intern_study_guide/data/departments.dart';
import 'package:intern_study_guide/data/intern_model.dart';
import 'package:intern_study_guide/widgets/textformfield_widget.dart';

class RegisterDialog extends StatefulWidget {
  String? selected;
  String? myTitle;
  RegisterDialog({Key? key, required this.selected, this.myTitle}) : super(key: key);

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _workemail = new TextEditingController();
    TextEditingController _pfnumber = new TextEditingController();
    Departments deps = new Departments();

    String dropValue = deps.dropValue;
    bool isLoading = false;
    bool isDone = false;
    //var selected = this.selected;

    print(widget.selected);
    switch (widget.selected) {
      case 'intern':
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
                  Text("Register as intern"),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Divider(),
                      TextFormField(
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
                      ),
                      TextFormField(
                        controller: _workemail,
                        style: TextStyle(
                            // decoration: InputDecoration(),
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Work Email',
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

                Divider(color: Colors.white,),
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_back_ios)),
                        VerticalDivider(
                          color: Colors.white,  //color of divider
                          //width: 10, //width space of divider
                          //thickness: 3, //thickness of divier line
                         // indent: 10, //Spacing at the top of divider.
                         // endIndent: 10,
                        ),
                        IconButton(onPressed: () async {
                          String url = endpoints.internPost();
                          InternDetails internDetails =
                              await GenericService<InternDetails>().create(
                              url,
                              InternDetails(
                                  pfNumber: _pfnumber.text,
                                  workEmail: _workemail.text,
                                  department: dropValue));
                           //Navigator.of(context).pop();
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

      case 'supervisor':
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
                  Text("Register as Supervisor"),
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
                        controller: _workemail,
                        style: TextStyle(
                          // decoration: InputDecoration(),
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Work Email',
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

                Divider(color: Colors.white,),
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_back_ios)),
                        VerticalDivider(
                          color: Colors.white,  //color of divider
                          //width: 10, //width space of divider
                          //thickness: 3, //thickness of divier line
                          // indent: 10, //Spacing at the top of divider.
                          // endIndent: 10,
                        ),
                        IconButton(onPressed: () async {
                          String url = endpoints.contentCreatorPost();
                          ContentCreatorDetails contentCreatorDetails =
                          await GenericService<ContentCreatorDetails>().create(
                              url,
                             ContentCreatorDetails(workEmail: _workemail.text,department: dropValue,role: 'supervisor'));
                          //Navigator.of(context).pop();
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

      case 'another':
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
                  Text("Register as ${widget.myTitle}"),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Divider(),
                      TextFormField(
                        controller: _workemail,
                        style: TextStyle(
                          // decoration: InputDecoration(),
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Work Email',
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

                Divider(color: Colors.white,),
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_back_ios)),
                        VerticalDivider(
                          color: Colors.white,  //color of divider
                          //width: 10, //width space of divider
                          //thickness: 3, //thickness of divier line
                          // indent: 10, //Spacing at the top of divider.
                          // endIndent: 10,
                        ),
                        IconButton(onPressed: () async {
                          String url = endpoints.contentCreatorPost();
                          //print(widget.myTitle);
                          ContentCreatorDetails contentCreatorDetails =
                          await GenericService<ContentCreatorDetails>().create(
                              url,
                              ContentCreatorDetails( workEmail: _workemail.text, department: dropValue, role: widget.myTitle));
                          //Navigator.of(context).pop();
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
        break;

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
