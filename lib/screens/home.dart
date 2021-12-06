import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:charitytime/screens/profile.dart';

import 'assets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:image/image.dart' as Img;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
 
import 'dart:math' as Math;

class MyHomePage extends StatefulWidget {
  final VoidCallback signOut;

  MyHomePage(this.signOut);
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
 
  String unameAPI, lnameAPI, fnameAPI, mnameAPI,img,d;
  double statuss,donated=0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      uAPI = preferences.getInt("user_ID");
      statuss = preferences.getDouble("statuss");
      unameAPI = preferences.getString("User");
      fnameAPI = preferences.getString("Fname");
      lnameAPI = preferences.getString("Lname");
      mnameAPI = preferences.getString("Email");
      img = preferences.getString("img");
    });
  }
  String message='';
  int value, uAPI;
   signOut() {
    setState(() {
      widget.signOut();
    });
  }
    
  Future<List> getData() async{
    final response = await http.get("http://charitytime2020.000webhostapp.com/getData.php");
    return json.decode(response.body);
  }
  
  final _key = GlobalKey<FormState>();
  String username="";
  double donatepeso=0.0;
  int ongo = 0;
  DateTime startTime;
  var stopTime;
  Duration timeDiff;
  var pesoEarned = 0.0;
  var totalPeso = 0.0;
  @override 
  void initState() {
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
  void updateDon(){
    var url ="http://charitytime2020.000webhostapp.com/editData.php";
   http.post(url, body: {
      "uid": unameAPI,
      "don": (totalPeso).toString(),
    });
    var route = new MaterialPageRoute(
                        builder: (BuildContext context) => 
                          new MyHomePage(signOut)
                      );
                      Navigator.of(context).push(route);
    
  }
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
            child: Form(
              key: _key,
              child: ListView(
                children:  
                [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                   AutoSizeText('Charity Time',style: titlestyle,),
                    Container(child:FlatButton(
                      child: Icon(Icons.person_outline, color: Colors.white70,),
                    onPressed: (){
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) => 
                          new ProfilePage(signOut)
                      );
                      Navigator.of(context).push(route);
                    },
                    
                    ), decoration: BoxDecoration(shape: BoxShape.circle,color:anotherGreen))
                  ],),
                  SizedBox(height: 15.0,),
                  Container(
                  height: 60.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child:AutoSizeText("$unameAPI: ", style:fontButtonw),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [cgreen(), anotherGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  ),
                  
                  SizedBox(height: 15.0,),
                  Container(
                    height: 300.0,
                    child:  ongo==0 ? Padding(child:AutoSizeText("Press Start Button to Start when you are ready",
                  style:TextStyle(fontSize: 30, fontFamily: "Montserrat"),
                  textAlign: TextAlign.center,
                  ), padding: EdgeInsets.only(top: 60),)
                    : Image(image: AssetImage("img/stopwatch-gif-9.gif"),
                    )
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [anotherGreen, cgreen()],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [.5,.9]
                    ),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: ongo==0 ? MaterialButton(
                    child:AutoSizeText("Start"),
                    
                    onPressed:
              (){
                setState(() {
                    ongo = 1;
                    startTime = new DateTime.now();
                    print(startTime);
                });
              }
                  ): MaterialButton(
                    onPressed: (){
                      setState(() {
                    ongo = 0;
                    timeDiff = new DateTime.now().difference(startTime);
                    pesoEarned = (timeDiff.inSeconds/60)*.5;
                    totalPeso += pesoEarned;
                    print(pesoEarned);
                      });
                      if(_key.currentState.validate()){
                      updateDon();
                      }
                    },
                    child:AutoSizeText("Submit")
                  )
                  ),
              
                ],
            ),
            
    ),
    
    )),
    bottomSheet: FlatButton(onPressed: (){
    
        signOut();
      
},
child: Row(children: <Widget>[
       Icon(
   Icons.exit_to_app,
   color: Color(0xff21bf73),
   size: 30.0
 ),

 Padding(padding: EdgeInsets.symmetric(horizontal: 7),
 child: AutoSizeText('Log Out',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
 ),
 ),

],)
),
    );
  }
}
