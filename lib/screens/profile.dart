import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'accountsettings_page.dart';
import 'assets.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  List list;
  int index;
  int uid;
  final VoidCallback signOut;
  ProfilePage(this.signOut);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String unameAPI, lnameAPI, fnameAPI, mnameAPI,img;
  double statuss;
  int value, uAPI;
getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      uAPI = preferences.getInt("user_ID");
      unameAPI = preferences.getString("User");
      fnameAPI = preferences.getString("Fname");
      lnameAPI = preferences.getString("Lname");
      statuss = preferences.getDouble("statuss");
      mnameAPI = preferences.getString("Email");
    });
  }
Future<List> getprof() async {
    final response = await http.get("http://charitytime2020.000webhostapp.com/getData.php?uname="+unameAPI);
   return json.decode(response.body);
     
}
  signOut() {
    setState(() {
      widget.signOut();
    });
  }
  @override
  void initState() {
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    final logout = FlatButton(onPressed: (){
    signOut();
},
  child: Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title:AutoSizeText('User Profile',style: TextStyle(fontFamily: "Bebas",color:anotherGreen)),
        actions: 
        <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size:25.0 ,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-105,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              var route = new MaterialPageRoute(
                        builder: (BuildContext context) => 
                          new AccountS(signOut)
                      );
                      Navigator.of(context).push(route);
            },
          )
        ],
        flexibleSpace: Container(
           decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [cgreen(), anotherGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    ),
        ),),
        elevation: 0.0,
      ),
      body: FutureBuilder<List>(
        future: getprof(),
        builder:(context,snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
            return snapshot.hasData 
            ? new ItemList(list: snapshot.data) 
            : new Center(child: new CircularProgressIndicator());
          
        }
      ),
  
    );
  }
}
class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list ==null?0:list.length,
      itemBuilder:(context, i){
        return new Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:AutoSizeText(
                    "${list[i]['Fname'][0]}",
                    style: TextStyle(fontFamily: "Bebas",fontSize: 70),
                    textAlign: TextAlign.center,
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child:Text(
                    "${list[i]['Uname']}",
                    style: TextStyle(fontSize: 20,color: Colors.white ),
                    textAlign: TextAlign.center,
                    )
                  )]),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [cgreen(), anotherGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                    BoxShadow(
                      color: anotherGreen,
                      blurRadius: 5.0,
                      spreadRadius: 2.0, 
                      offset: Offset(
                        0.0,
                        5.0, 
                      ),
                    )
                  ],
                  ),
                  ),
                  SizedBox(height:25),
                  
              Container(
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "First Name",
                    style: TextStyle(fontSize: 15,
                    color: Colors.grey ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),
                  Container(
                   alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                 
                  child:AutoSizeText(
                    "${list[i]['Fname']}",
                    style: TextStyle(fontSize: 20,fontFamily: "Montserrat" ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),
                  Container(
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "Last Name",
                    style: TextStyle(fontSize: 15,
                    color: Colors.grey ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),
                  Container(
                   alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "${list[i]['Lname']}",
                    style: TextStyle(fontSize: 20,fontFamily: "Montserrat"),
                    textAlign: TextAlign.left,
                    
                  )),
                  SizedBox(height:15),
                  Container(
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "Email Address",
                    style: TextStyle(fontSize: 15,
                    color: Colors.grey ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),
          Container(
                   alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "${list[i]['Email']}",
                    style: TextStyle(fontSize: 20,fontFamily: "Montserrat" ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),Container(
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "Total Donated",
                    style: TextStyle(fontSize: 15,
                    color: Colors.grey ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(height:15),
          Container(
                   alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                  child:AutoSizeText(
                    "P${list[i]['Donated']}",
                    style: TextStyle(fontSize: 20,fontFamily: "Montserrat"),
                    textAlign: TextAlign.left,
                  )),
        ],
      );
      }
    );
  }
}

      