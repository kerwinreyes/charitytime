import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile.dart';

class AccountS extends StatefulWidget {
 
  final VoidCallback signOut;
  AccountS(this.signOut); 

  @override
  _AccountSState createState() => _AccountSState();
}

class _AccountSState extends State<AccountS> {
int value, uAPI;
String unameAPI,fnameAPI, mnameAPI,lnameAPI;
double statuss;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      uAPI = preferences.getInt("user_ID");
      unameAPI = preferences.getString("User");
      fnameAPI = preferences.getString("Fname");
      mnameAPI = preferences.getString("Email");
      lnameAPI = preferences.getString("Lname");
      statuss = preferences.getDouble("statuss");
    });
  }
  final _key = new GlobalKey<FormState>();
  TextEditingController _fname;
  TextEditingController _uname;
  TextEditingController _lname;
  TextEditingController _mname;
  TextEditingController _pass = new TextEditingController();
  String message='';
  Future<List> getData() async{
  _fname.text= fnameAPI;
    final response = await http.get("http://charitytime2020.000webhostapp.com/getData.php?&uname="+'$uAPI',);
    return json.decode(response.body);
  }
 void update(){
    var url ="http://charitytime2020.000webhostapp.com/updateProf.php";
   http.post(url, body: {
      "uid": unameAPI,
      "fname": _fname.text,
      "lname": _lname.text,
      "email": _mname.text,
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
   savePref(int value, int uID, String u, String f,String m,String l, double s) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setInt("user_ID", uID);
      preferences.setDouble("statuss", s);
      preferences.setString("User", u);
      preferences.setString("Fname", f);
      preferences.setString("Email", m);
      preferences.setString("Lname", l);
      preferences.commit();
    });
  }
  @override
  void initState() {
    
    super.initState();
    getPref();
    _fname = new TextEditingController(text: fnameAPI);
    _lname = new TextEditingController(text: lnameAPI);
    _mname = new TextEditingController(text: mnameAPI);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AutoSizeText('Account Settings', style:TextStyle(fontFamily: "Futura", fontSize: 22, color: Color(0xff21bf73), fontWeight: FontWeight.bold)
        ,),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back,
          color: Color(0xff21bf73)),
           onPressed:(){
             Navigator.pop(context);
           }),
        ],
       ),
    backgroundColor: Colors.white,
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
class ItemList extends StatefulWidget {
  final List list;
  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int value, uAPI;

String unameAPI,fnameAPI, mnameAPI,lnameAPI;

double statuss;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      uAPI = preferences.getInt("user_ID");
      unameAPI = preferences.getString("User");
      fnameAPI = preferences.getString("Fname");
      mnameAPI = preferences.getString("Email");
      lnameAPI = preferences.getString("Lname");
      statuss = preferences.getDouble("statuss");
    });
  }
  
    final formKey = GlobalKey<FormState>();

  TextEditingController _fname;
  TextEditingController _uname;
  TextEditingController _lname;
  TextEditingController _mname;
  TextEditingController _pass = new TextEditingController();
 void update(){
    var url ="http://charitytime2020.000webhostapp.com/updateProf.php";
   http.post(url, body: {
      "uid": unameAPI,
      "fname": _fname.text,
      "lname": _lname.text,
      "email": _mname.text,
    });
  }
   @override
  void initState() {
    
    super.initState();
    getPref();
    _fname = new TextEditingController(text: widget.list[0]['Fname']);
    _lname = new TextEditingController(text: widget.list[0]['Lname']);
    _mname = new TextEditingController(text: widget.list[0]['Email']);
  }
  @override
  Widget build(BuildContext context) {
final fname =
    TextField(
        controller: _fname,
      cursorColor: Color(0xff21bf73),
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color:Color(0xff21bf73)),
        hintText: fnameAPI,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
         ),
    );

final lname =
      TextField(
        autofocus: false,
        controller: _lname,
        obscureText: false,
        cursorColor: Color(0xff21bf73),
        decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline, color:Color(0xff21bf73)),
          hintText: lnameAPI,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
        ),
      );


final email =
    TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _mname,
      autofocus: false,
      cursorColor: Color(0xff21bf73),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color:Color(0xff21bf73)),
        hintText: mnameAPI,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
         ),
      );  





final pass =
    TextField(
      keyboardType: TextInputType.emailAddress,
      
      autofocus: false,
      cursorColor: Color(0xff21bf73),
      obscureText: true,
        controller: _pass,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color:Color(0xff21bf73)),
        hintText: ' Password',
        helperText: 'Password must have at least 8 characters, 1 upper case and 1 number.',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
         ),
      );






final charity = Row(
  children: <Widget>[
    FlatButton(onPressed:(){},
    child: Center(
      child: Container(
      child: Row(children: <Widget>[
        Icon(
          Icons.group,
          size: 30.0,
          color: Color(0xff21bf73),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 7),
        child: Text('Change Charity',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
        )
        ),
      ],)
    ),
    ),
    ),
  ],
    

);

final sponsor = Row(
  children: <Widget>[
    FlatButton(onPressed:(){},
    child: Center(
      child: Container(
      child: Row(children: <Widget>[
        Icon(
          Icons.group_work,
          size: 30.0,
          color: Color(0xff21bf73),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 7),
        child: Text('Change Sponsor',
 style: TextStyle(fontSize: 20.0,
 color: Colors.black87)
        )
        ),
      ],)
    ),
    ),
    ),
  ],
    

);


    return ListView.builder(
      itemCount: widget.list ==null?0:widget.list.length,
      itemBuilder:(context, i){
        return new Center(child: Form(
        key: formKey,
      child:
      Container(
      height: MediaQuery.of(context).size.height,
      
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height:30),
              fname,
              SizedBox(height:10),
              lname,
              SizedBox(height:20),
              email,
              SizedBox(height:20),
              pass,
              Container(
      width: double.infinity,
      height: 80.0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child:FlatButton(onPressed:(){
          if(formKey.currentState.validate()){
                update();
              }
        },
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AutoSizeText( 'SAVE CHANGES',
            style: TextStyle(fontSize: 20.0,
            color: Colors.black87),

                        ),
                    SizedBox(width: 8.0),

                    Icon(
                      Icons.save_alt,
                      size: 25.0,
                      color: Color(0xff21bf73),

                    )
                      ],

                    ),
                  )
                ),
                ),
            ],
          ),
        ),
      ),
    )
    );
      }
    );
  }
}

      
