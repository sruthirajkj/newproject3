import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notepad.dart';

class Notepadupdating extends StatefulWidget {
  const Notepadupdating({Key? key}) : super(key: key);

  @override
  State<Notepadupdating> createState() => _NotepadupdatingState();
}

class _NotepadupdatingState extends State<Notepadupdating> {
  TextEditingController txt=TextEditingController();
  TextEditingController txt1=TextEditingController();
  TextEditingController txt2=TextEditingController();

pst()async{
  final url="http://192.168.68.126:8080/updateNotes";
  var body={"title":txt.text,"content": txt1.text,"id":txt2.text};
  var rep=await post(Uri.parse(url),body: jsonEncode(body));
  if(rep.statusCode==200){
    print(rep.body);
  }

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.deepOrange,),

      floatingActionButton: FloatingActionButton( backgroundColor: Colors.deepOrange,
          onPressed: (){
        //postdata();
        // Navigator.of(context).push(
        //       MaterialPageRoute(builder: (context) => Notepadhome()));

        },child: (Text("save"))),
      // ),
      body: SafeArea(
        child: (Column( children: [TextField(
          controller: txt,
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
    TextField(
      controller: txt1,
    decoration: InputDecoration(
    hintText: "Start typing",
    hintStyle: TextStyle(color: Colors.black38),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)))),
    maxLines: null,
    ),
        ],)),
      )
    );

  }
}
