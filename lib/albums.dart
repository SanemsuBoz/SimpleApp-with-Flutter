import 'package:ff/db/dbPhoto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

import 'models/photo.dart';
import 'models/utility.dart';

class Albums extends StatefulWidget {
  Albums() : super();

  final String title = "Albums";

  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  Future<File> imageFile;
  Image image;
  DbPhoto dbPhoto;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbPhoto = DbPhoto();
    refreshImages();
  }

  refreshImages() {
    dbPhoto.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
      Photo photo = Photo(imgString);
      dbPhoto.insert(photo);
      refreshImages();
    });
  }

  pickImageFromCamera() {
    ImagePicker.pickImage(source: ImageSource.camera).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
      Photo photo = Photo(imgString);
      dbPhoto.insert(photo);
      refreshImages();
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return Utility.imageFromBase64String(photo.photoName);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.photo_library),
                    onPressed: () => pickImageFromGallery(),
                  ),
                  IconButton(
                    color: Colors.blue,
                    padding: EdgeInsets.only(left: 280),
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => pickImageFromCamera(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
