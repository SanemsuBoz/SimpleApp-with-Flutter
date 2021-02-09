import 'package:ff/albums.dart';
import 'package:flutter/material.dart';
import 'db/dbHelper.dart';

import 'diaryPages.dart';
import 'diaryPagesDetail.dart';
import 'models/diaryPagesInformation.dart';
import 'models/photo.dart';

class MyTravelDiary extends StatefulWidget {
  @override
  _MyTravelDiaryState createState() => _MyTravelDiaryState();
}

enum Choice { CreatePage, Album }

class _MyTravelDiaryState extends State<MyTravelDiary> {
  DbHelper dbHelper = new DbHelper();
  List<DiaryPagesInformation> diaryPagesInformation;
  Photo photo;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (diaryPagesInformation == null) {
      diaryPagesInformation = new List<DiaryPagesInformation>();
      getData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Travel Diary'),
        actions: [
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              PopupMenuItem<Choice>(
                child: Text("Create New Page"),
                value: Choice.CreatePage,
              ),
              PopupMenuItem<Choice>(
                child: Text("Go To Album"),
                value: Choice.Album,
              ),
            ],
          ),
        ],
      ),
      body: diaryPagesLists(),
    );
  }

  ListView diaryPagesLists() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.blue[100 * ((position) % 9)],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[300],
              child: Text(
                this.diaryPagesInformation[position].id.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(this.diaryPagesInformation[position].placeName),
            subtitle: Text(this.diaryPagesInformation[position].date),
            onTap: () {
              goToDetail(this.diaryPagesInformation[position]);
            },
          ),
        );
      },
    );
  }

  void getData() {
    var db = dbHelper.initializeDb();
    db.then((value) {
      var diaryPagesInformationFuture = dbHelper.getDiaryPagesInformation();
      diaryPagesInformationFuture.then((data) {
        List<DiaryPagesInformation> diaryPagesData =
            new List<DiaryPagesInformation>();
        count = data.length;
        for (int i = 0; i < count; i++) {
          diaryPagesData.add(DiaryPagesInformation.fromObject(data[i]));
        }
        setState(() {
          diaryPagesInformation = diaryPagesData;
          count = count;
        });
      });
    });
  }

  void goToDetail(DiaryPagesInformation diaryPagesInformation) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DiaryPagesDetail(diaryPagesInformation)));
    if (result != null) {
      if (result) {
        getData();
      }
    }
  }

  void select(Choice choice) async {
    switch (choice) {
      case Choice.CreatePage:
        bool result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryPages()));
        if (result != null) {
          if (result) {
            getData();
          }
        }
        break;
      case Choice.Album:
        bool result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Albums()));
        if (result != null) {
          if (result) {
            getData();
          }
        }
        break;
      default:
    }
  }

  void goToPage() async {}
}
