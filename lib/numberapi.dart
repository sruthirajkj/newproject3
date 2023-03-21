import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Numberapi extends StatefulWidget {
  const Numberapi({Key? key}) : super(key: key);

  @override
  State<Numberapi> createState() => _NumberapiState();
}

class _NumberapiState extends State<Numberapi> {
  //var numresp;
  TextEditingController numtext=TextEditingController();
 Future<dynamic> numget()
  async{
    final url="http://numbersapi.com/${numtext.text}";
   var resp= await get(Uri.parse(url));
  // print(resp.body);

   if(resp.statusCode==200)
   {
     var body=jsonDecode(resp.body);
     print(body);

     return body;

   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    SafeArea(
      child: Center(child: Column(
        children: [TextField(
          controller: numtext,
          decoration: InputDecoration(
              hintText: "Enter the numbers",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
          ElevatedButton(
              onPressed: () {

                numget();
                setState(() {

                });

              },child: Text("click")),
          FutureBuilder(future: numget(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return CircularProgressIndicator();
              }
              if(snapshot.hasData)
              {
                return Text(snapshot.data.toString());
              }
              else{
                return Text("something went wrong");
              }
            },
          )

        ],
      ),
      ),
    ),
    );
  }
}
