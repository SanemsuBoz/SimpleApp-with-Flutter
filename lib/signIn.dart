import 'package:ff/db/dbUser.dart';
import 'package:ff/signUp.dart';
import 'package:flutter/material.dart';

import 'myTravelDiary.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  DbUser dbUser = DbUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 400,
                    height: 200,
                    child: Image.asset('asset/images/loginpageimage.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextFormField(
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
              child: TextFormField(
                controller: txtPassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  entered();
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUp()));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void entered() async {
    bool value = await dbUser.emailPassword(txtEmail.text, txtPassword.text);
    if (value == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyTravelDiary()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
      AlertDialog alertDialog =
          new AlertDialog(title: Text("Check Your Password or Email Address"));
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
