import 'package:flutter/material.dart';
import 'db/dbHelper.dart';
import 'models/diaryPagesInformation.dart';

class DiaryPages extends StatefulWidget {
  @override
  _DiaryPagesState createState() => _DiaryPagesState();
}

class _DiaryPagesState extends State<DiaryPages> {
  DbHelper helper = DbHelper();
  TextEditingController txtPlaceName = new TextEditingController();
  TextEditingController txtDate = new TextEditingController();
  TextEditingController txtExplanation = new TextEditingController();
  double get height => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar,
      body: buildBody,
      floatingActionButton: buildAppSave,
    );
  }

  AppBar get buildAppBar => AppBar(title: Text('Create Diary Page'));

  Center get buildBody {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: txtPlaceName,
                    decoration: InputDecoration.collapsed(
                        hintText: "Place Name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: txtDate,
                    decoration: InputDecoration.collapsed(
                        hintText: "Date", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: txtExplanation,
                    decoration: InputDecoration.collapsed(
                        hintText: "Note", border: OutlineInputBorder()),
                    maxLines: 20,
                  )
                ],
              )),
        ],
      ),
    );
  }

  FloatingActionButton get buildAppSave {
    return FloatingActionButton.extended(
      heroTag: "btn1",
      label: Text("Save"),
      onPressed: () {
        saveBtn();
      },
    );
  }

  void saveBtn() async {
    int result = await helper.insert(DiaryPagesInformation(
        txtPlaceName.text, txtExplanation.text, txtDate.text));
    if (result != 0) {
      Navigator.pop(context, true);
    }
    AlertDialog alertDialog = new AlertDialog(title: Text("Save Page"));
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
