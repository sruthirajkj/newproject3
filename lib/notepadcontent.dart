import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notepad.dart';
import 'notepadupdatingpage.dart';

class Notepadcontent extends StatefulWidget {
  Notepadcontent({Key? key, required this.title, required this.content,required this.id})
      : super(key: key);
  String? title;
  String? content;
  String?id;

  @override
  State<Notepadcontent> createState() => _NotepadcontentState();
}

class _NotepadcontentState extends State<Notepadcontent> {
  TextEditingController txt=TextEditingController();
  TextEditingController txt1=TextEditingController();
  pst()async{
    final url="http://192.168.68.126:8080/updateNotes";
    var body={"title":txt.text,"content": txt1.text,"id":widget.id};
    var rep=await post(Uri.parse(url),body: jsonEncode(body));
    if(rep.statusCode==200){
      print(rep.body);
      var r=jsonDecode(rep.body);
      if( r["message"]=="note updated"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Notepadhome()));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("somthing went wrong")));
      }
    }

  }

  k(){
    setState(() {
      txt.text  = widget.title.toString();
      txt1.text= widget.content.toString();
    });}

  @override
  void initState() {
    k();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange, actions: [Icon(Icons.share)]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {pst();
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return Notepadupdating();
            // }));
          },
          child: Text("update")),
      body: SafeArea(
          child: Column(
        children: [
          TextField(controller: txt,
            decoration: InputDecoration(
                hintText: "title",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 150,
                child: Text("Day/Month/Year",
                    style: TextStyle(color: Colors.black26)),
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
          TextField(
            controller: txt1,
            decoration: InputDecoration(
                hintText: "content",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
          ),
        ],
      )),
    );
  }
}
