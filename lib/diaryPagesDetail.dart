import 'package:ff/myTravelDiary.dart';
import 'package:flutter/material.dart';

import 'db/dbHelper.dart';

import 'models/diaryPagesInformation.dart';

// ignore: must_be_immutable
class DiaryPagesDetail extends StatefulWidget {
  DiaryPagesInformation diaryPagesInformation;
  DiaryPagesDetail(this.diaryPagesInformation);

  @override
  State<StatefulWidget> createState() =>
      DiaryPagesDetailState(diaryPagesInformation);
}

enum Choice { Delete }

class DiaryPagesDetailState extends State {
  DiaryPagesInformation diaryPagesInformation;
  DiaryPagesDetailState(this.diaryPagesInformation);
  DbHelper dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Travel Diary Pages ${diaryPagesInformation.placeName}"),
        actions: [
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              PopupMenuItem<Choice>(
                child: Text("Delete Pages"),
                value: Choice.Delete,
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Text(diaryPagesInformation.placeName),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text(diaryPagesInformation.date),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text(diaryPagesInformation.explanation),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void select(Choice choice) async {
    int result;
    int rPhoto;
    switch (choice) {
      case Choice.Delete:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyTravelDiary()));
        result = await dbHelper.delete(diaryPagesInformation.id);
        if (result != 0 && rPhoto != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Deleted : ${diaryPagesInformation.placeName}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      default:
    }
  }
}
