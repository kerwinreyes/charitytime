import 'package:flutter/material.dart';
import 'accountsettings_page.dart';
import 'Login.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {

final formKey = GlobalKey<FormState>();



signOut(){}

final myaccount = FlatButton(onPressed: (){
  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountS(signOut())),
    );
},
child: Center(
  child: Container(
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
child: Row(children: <Widget>[
 Icon(
   Icons.person_pin,
   size: 30.0,
   color: Color(0xff21bf73),
 ),

 Padding(padding: EdgeInsets.symmetric(horizontal: 7),
 child:  Text('Account Settings',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
 ),
 ),

],)
),
),
);


final help = FlatButton(onPressed: (){
},
  child: Container(
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
child: Row(children: <Widget>[
       Icon(
   Icons.perm_device_information,
   size: 30.0,
   color: Color(0xff21bf73),
 ),

 Padding(padding: EdgeInsets.symmetric(horizontal: 7),
 child:  Text('Help Center',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
 ),
 ),

],)
),
);


final logout = FlatButton(onPressed: (){
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
 child:  Text('Log Out',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
 ),
 ),

],)
),
);








    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('SETTINGS', style:TextStyle(fontFamily: "Futura", fontSize: 32, color: Color(0xff21bf73), fontWeight: FontWeight.bold)
        ,),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back,
          color: Color(0xff21bf73)),
           onPressed:(){}),
        ],
      ),
      backgroundColor: Colors.white,
       body: Container(
            height: MediaQuery.of(context).size.height,
         child:Form(
         key: formKey,
         child: Container(
         child: ListView(
           children: <Widget>[
             SizedBox(height:10),
             myaccount,
             SizedBox(height:10),
             help,
        SizedBox(height: MediaQuery.of(context).size.height-250),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(),
            child: logout,
          ),
        ),

             

           ],
         ),
       ),
         ),
       ),
       
    );
  }
}