import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notepad.dart';

class Notepadpagadding extends StatefulWidget {
  const Notepadpagadding({Key? key}) : super(key: key);

  @override
  State<Notepadpagadding> createState() => _NotepadpagaddingState();
}

class _NotepadpagaddingState extends State<Notepadpagadding> {
  TextEditingController txt=TextEditingController();
  TextEditingController txt2=TextEditingController();
  postdata()async {
    final url = "http://192.168.68.126:8080/addNotes";
    var bodys = {"title": txt.text, "content": txt2.text};
    var resp = await post(Uri.parse(url), body: jsonEncode(bodys));
    if (resp.statusCode == 200) {
      print(resp.body);
      var r =jsonDecode(resp.body);
      if(r["message"]=="inserted"){
        Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Notepadhome()));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepOrange,
        onPressed: () {postdata();
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => Notepadpagadding()));
        },
        child: Text("Save")),
      appBar: AppBar(backgroundColor: Colors.deepOrange,actions: [Icon(Icons.add)]),
      body: SafeArea(
        child: Column(children: [
          TextField(controller: txt,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 150,
                  child: Text("Day/Month/Year",style: TextStyle(color: Colors.black26)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(width: .5, color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: 80,
                    child: Text("0 charaters",
                        style: TextStyle(color: Colors.black26)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(width: .5, color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(controller: txt2,
              decoration: InputDecoration(
                  hintText: "Start typing",
    hintStyle: TextStyle(color: Colors.black38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              maxLines: null,
            ),
          )
          
        ]),
      ),
    );
  }
}
