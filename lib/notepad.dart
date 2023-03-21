import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notepadcontent.dart';
import 'notepadpageadding.dart';

class Notepadhome extends StatefulWidget {
  const Notepadhome({Key? key}) : super(key: key);

  @override
  State<Notepadhome> createState() => _NotepadhomeState();
}

class _NotepadhomeState extends State<Notepadhome> {
  Future<dynamic> getdata() async {
    final url = "http://192.168.68.126:8080/getNotes";
    //var bodys={};
    var resp = await get(Uri.parse(url));
    if (resp.statusCode == 200) {
      print(resp.body);
      var body = jsonDecode(resp.body);

      return body;
    }
  }

  deletedata(int id) async {
    final url = "http://192.168.68.126:8080/removeNotes";
    var body = {"id": id};
    var res = await post(Uri.parse(url), body: jsonEncode(body));
    if (res.statusCode == 200) {
      print(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Notepadpagadding()));
          },
          child: Text("+")),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text("NOTEPAD"),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SafeArea(
        child: (Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                  decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 20),
                suffixIcon: Align(
                    heightFactor: 2.0,
                    widthFactor: 2.0,
                    child: Icon(Icons.search)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!["message"].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 10, bottom: 10, left: 20),
                                child: InkWell(
                                  onTap: () {
                                    //String name="sruthi";
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Notepadcontent(
                                        title: snapshot.data!["message"][index]
                                            ["title"],
                                        id: snapshot.data!["message"][index]
                                                ["id"]
                                            .toString(),
                                        content: snapshot.data!["message"]
                                            [index]["content"],
                                      );
                                    }));
                                    // print(snapshot.data!["message"][index]
                                    // ["title"]);
                                    // print(snapshot.data!["message"][index]
                                    // ["content"]);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!["message"][index]
                                                ["title"]
                                            .toString()),
                                        Text(snapshot.data!["message"][index]
                                                ["content"]
                                            .toString()),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {

                                              });
                                                deletedata(
                                                    snapshot.data!["message"]
                                                        [index]["id"]);
                                            },
                                            child: Text("Delete"))
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black45, width: 3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Text("something wrong");
                    }
                  }),
            )
          ],
        )),
      ),
    );
  }
}
