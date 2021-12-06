import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:charitytime/screens/assets.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
enum LoginStatus { notSignIn, signIn }

class _SignUpPageState extends State<SignUpPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  bool _secureText= true;
  bool _secureText1= true;
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _useremail = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _cpassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String unameAPI, lnameAPI, fnameAPI, mnameAPI,img, message;
  int value=0, uAPI;
  String confirmMsg;
  signUp() async {
    final response = await http.post("http://charitytime2020.000webhostapp.com/register.php", body: {
      "fname": _fname.text,
      "lname": _lname.text,
      "email": _useremail.text,
      "pass": _password.text,
      "uname": _username.text,
    });
    final data = jsonDecode(response.body);
    value = data['value'];
    message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }
  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: value == 1 ? Colors.green : Colors.red,
        textColor: Colors.white);
  }
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    final fname =
    TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _fname,
      validator: (e){
        if(e.isEmpty){
          return "Please Enter First Name!";
        }
        else if(!e.contains(RegExp(r'^[a-zA-Z]+$'))){
          return "Invalid First Name";
        }
      },
      cursorColor: Color(0xff21bf73),
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color:Color(0xff21bf73)),
        hintText: ' First Name',
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
      TextFormField(
        autofocus: false,
        controller: _lname,
      validator: (e){
        if(e.isEmpty){
          return "Please Enter Last name!";
        }
        else if(!e.contains(RegExp(r'^[a-zA-Z]+$'))){
          return "Invalid Last Name";
        }
      },
        obscureText: false,
        cursorColor: Color(0xff21bf73),
        decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline, color:Color(0xff21bf73)),
          hintText: ' Last Name',
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
    TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _useremail,
      validator: (e){
        if(e.isEmpty){
          return "Please Enter Your Email!";
        }
        else if(!e.contains('@')){
          return "Invalid Email";
        }
      },
      autofocus: false,
      cursorColor: Color(0xff21bf73),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color:Color(0xff21bf73)),
        hintText: ' Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
         ),
      );  


final user =
      TextFormField(
        autofocus: false,
        controller: _username,
        validator: (e){
        if(e.isEmpty){
          return "Please Enter User Name!";
        }
        else if(!e.contains(RegExp(r'^[a-zA-Z]+$'))){
          return "Invalid User Name";
        }
      },
        cursorColor: Color(0xff21bf73),
        obscureText: false,
        decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_pin, color:Color(0xff21bf73)),
          hintText: ' User Name',
          helperText: 'You can use letters, numbers & periods.',
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
    TextFormField(
      controller: _password,
      validator: (e){
        if(e.isEmpty){
          return "Please Enter Password!";
        }
        if(e.length < 8){
          return "Password must be atleast 8 characters long";
        }
      },
      autofocus: false,
      cursorColor: Color(0xff21bf73),
      obscureText: _secureText,
      decoration: InputDecoration(
         suffixIcon: 
        IconButton(
            onPressed: showHide,
            icon: Icon(_secureText
                ? Icons.visibility_off
                : Icons.visibility),
          ),
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

final cpass =
      TextFormField(
        autofocus: false,
        controller: _cpassword,
        validator: (e){
        if(e.isEmpty){
          return "Please Confirm Password!";
        }
        else if (e!= _password.text){
          return "Passwords doesn\'t match.\nTry Again!";

        }
        },
        cursorColor: Color(0xff21bf73),
        obscureText: _secureText,
        decoration: InputDecoration(
           suffixIcon: 
        IconButton(
            onPressed: showHide,
            icon: Icon(_secureText
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        prefixIcon: Icon(Icons.lock_outline, color:Color(0xff21bf73)),
          hintText: " Confirm Password",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff21bf73)),
            borderRadius: BorderRadius.circular(50.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50.0)),
        ),
      );



    final nextbutton = Padding(
        padding: EdgeInsets.symmetric(vertical:16.0),
        child: Material(
          borderRadius: BorderRadius.circular(100.0),
          shadowColor: Colors.black,
          elevation: 5.0,
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: (){
              if(formKey.currentState.validate()){
                signUp();
              }
            },
          color: Color(0xff21bf73),
          child:AutoSizeText('Create an Account', style: TextStyle(color: Colors.white),
          ),
        ),
        ),
    );




    final account = FlatButton(
      child: Center(
        child: Column( children: <Widget>[
         AutoSizeText('Already have an Account?',
      textAlign: TextAlign.center,
       style: TextStyle(color : Colors.black54), 
        ),
       AutoSizeText('LOG IN',
      textAlign: TextAlign.center,
       style: TextStyle(color : Color(0xff21bf73)), 
        ),
        ],
      ),
      ),
        onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> LoginPage()));
        }, 
      );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Container(
          child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left:24.0,right:24.0),
          children: <Widget>[
            Center(
              child:AutoSizeText(
              "Sign Up",
              style: fontButton4,
              ),
            ),
            SizedBox(height: 20.0,),
            fname,
            SizedBox(height: 8.0,),
            lname,
            SizedBox(height: 20.0,),
            email,
            SizedBox(height: 8.0,),
            user,
            SizedBox(height: 16.0,),
            pass,
            SizedBox(height: 8.0,),
            cpass,
            SizedBox(height: 8.0,),
            nextbutton,
             account,
          ],
        ),),),)
    );
  }
}
