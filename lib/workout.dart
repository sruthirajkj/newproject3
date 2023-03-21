// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';
//
// class workout extends StatefulWidget {
//   const workout({Key? key}) : super(key: key);
//
//   @override
//   State<workout> createState() => _workoutState();
// }
//
// class _workoutState extends State<workout> {
//   File? image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Column(
//         children: [
//           Center(
//             child: ElevatedButton(
//                 onPressed: () async {
//                   ImagePicker pick = ImagePicker();
//                   XFile? imgpick =
//                       await pick.pickImage(source: ImageSource.camera);
//                   if (imgpick != null) {
//                     print(imgpick.path);
//                     setState(() {
//                       image = File(imgpick.path);
//                     });
//                   }
//                 },
//                 child: Text("click")),
//           ),
//           image!=null?Container(
//             height: 100,
//             width: 100,
//             child: Image.file(image!),
//           ):Text("data")
//         ],
//       ),
//     ));
//   }
// }import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class Numberapi extends StatefulWidget {
//   const Numberapi({Key? key}) : super(key: key);
//
//   @override
//   State<Numberapi> createState() => _NumberapiState();
// }
//
// class _NumberapiState extends State<Numberapi> {
//   var numresp;
//   TextEditingController numtext=TextEditingController();
//   Future<dynamic> numget()
//   async{
//     final url="http://numbersapi.com/${numtext.text}";
//     var resp= await get(Uri.parse(url));
//
//     if(resp.statusCode==200)
//     {
//       var body=jsonDecode(resp.body);
//
//       return body;
//
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:
//     Center(child: Column(
//       children: [
//         FutureBuilder(future: numget(),
//           builder: (context,snapshot){
//             if(snapshot.connectionState==ConnectionState.waiting)
//             {
//               return CircularProgressIndicator();
//             }
//             if(snapshot.hasData)
//             {
//               return Column(  children: [
//                 TextField(
//                   controller: numtext,
//                   decoration: InputDecoration(
//                       hintText: "Enter the numbers",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20))),
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//
//                       numget();
//
//                     },child: Text("click")),
//                 Text(snapshot.data.toString()),
//               ],);
//             }
//             else{
//               return Text("something went wrong");
//             }
//           },
//         )
//       ],
//     ),
//     ),
//     );
//   }
// }
//
