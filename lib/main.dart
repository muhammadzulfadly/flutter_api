import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_data.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async {
    if (name.text != "" || email.text != "" || password.text != "") {
      try {
        String uri = "http://10.0.2.2/flutter_api/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("record inserted");
          name.text = "";
          email.text = "";
          password.text = "";
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all fileds");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('insert record'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('enter the name')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('enter the email')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('enter the password')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertrecord();
                },
                child: Text('insert'),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => view_data()));
                      },
                      child: Text("view data"));
                }))
          ],
        ),
      ),
    );
  }
}
