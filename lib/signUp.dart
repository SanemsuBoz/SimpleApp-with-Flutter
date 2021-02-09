import 'package:ff/db/dbUser.dart';
import 'package:ff/models/user.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  DbUser dbUser = DbUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Container(
                  width: 400,
                  height: 200,
                  child: Image.asset('asset/images/travel_people_icons.jpg')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10, bottom: 0),
            child: TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10, bottom: 0),
            child: TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: FlatButton(
              onPressed: () {
                save();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void save() async {
    bool value = await dbUser.chkEmail(txtEmail.text);
    if (value == false) {
      int result = await dbUser.insert(User(txtEmail.text, txtPassword.text));
      if (result != 0) {
        Navigator.pop(context, true);
      }
      AlertDialog alertDialog = new AlertDialog(title: Text("Save User"));
      showDialog(context: context, builder: (_) => alertDialog);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp()));
      AlertDialog alertDialog =
          new AlertDialog(title: Text("This Email Have Been Used Before"));
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
