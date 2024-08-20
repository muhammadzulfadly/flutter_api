import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List userdata = [];

  Future<void> getrecord() async {
    String uri = "http://10.0.2.2/flutter_api/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("view data")),
      body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                    title: Text(userdata[index]["uname"]),
                    subtitle: Text(userdata[index]["uemail"])));
          }),
    );
  }
}
