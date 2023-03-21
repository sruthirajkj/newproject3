

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Locationpermission extends StatefulWidget {
  const Locationpermission({Key? key}) : super(key: key);

  @override
  State<Locationpermission> createState() => _LocationpermissionState();
}

class _LocationpermissionState extends State<Locationpermission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: MaterialButton(
        color: Colors.red,
          onPressed: ()
      async{
        Location loactionss=Location();
        LocationData locatindata=await loactionss.getLocation();
        print(locatindata.longitude);

      }),)),
    );
  }
}
