import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'assets.dart';
import 'dart:async';
import 'dart:convert';
import '../sql/sqlservice.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
enum LoginStatus { notSignIn, signIn }
class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  String unameAPI, lnameAPI, fnameAPI, mnameAPI,img;
  double statuss;
  int value=0, uAPI;
  final _key = new GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _secureText = true;

 login() async {
    final response = await http.post("http://charitytime2020.000webhostapp.com/login.php", body: {
      "action": 'Login_Account',
      "uname": _username.text,
      "pass": _password.text,
    });

    final data = jsonDecode(response.body);
    value = data['not'];
    
    if (value == 1) {
      uAPI = int.parse(data['UID']);
      statuss = double.parse(data['Donated']);
      unameAPI = data['User'];
      fnameAPI = data['fname'];
      mnameAPI = data['email'];
      lnameAPI = data['lname'];
      img = data['img'];
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, uAPI,unameAPI, fnameAPI, mnameAPI,lnameAPI,img,statuss);
      });
      message ="Login Successful";
      print(message);
      loginToast(message);
    } else {
      message = "Login Failed";
      print(message);
      loginToast(message);
    }
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
    }
  }
  TextEditingController _email = new TextEditingController();
  String msg = '',message ="okay";
  String username ='', _user='',_pass='';
    
  
  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: value == 1 ? Colors.green : Colors.red,
        textColor: Colors.white);
  }

  savePref(int value, int uID, String u, String f,String m,String l,String i, double s) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setInt("user_ID", uID);
      preferences.setDouble("statuss", s);
      preferences.setString("User", u);
      preferences.setString("Fname", f);
      preferences.setString("Email", m);
      preferences.setString("Lname", l);
      preferences.setString("img", i);
      preferences.commit();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      uAPI = preferences.getInt("user_ID");
      statuss = preferences.getDouble("statuss");
      unameAPI = preferences.getString("User");
      fnameAPI = preferences.getString("Fname");
      mnameAPI = preferences.getString("Email");
      lnameAPI = preferences.getString("Lname");
      img = preferences.getString("img");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("user_ID", null);
      preferences.setDouble("statuss", null);
      preferences.setString("User", null);
      preferences.setString("Fname", null);
      preferences.setString("Email", null);
      preferences.setString("Lname", null);
      preferences.setString("img", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }
  @override
  void initState() {
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {

    AssetImage ficon  = AssetImage('img/CharityTimeLogo.png');

    final email = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0))
      ),
      style: fontField,
    );
    final user = TextFormField(
      controller: _username,
      validator: (e) {
        if (e.isEmpty) {
          return "Please Insert Username"; }
      },
      onSaved: (e) => _username.text = e,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0))
      ),
      style: fontFieldB,
    );

    final password = TextFormField(
      controller: _password,
      validator: (e) {
        if (e.isEmpty) {
          return "Password Can't be Empty";
        }
      },
      obscureText: _secureText,
      onSaved: (e) => _password.text = e,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: 
        IconButton(
            onPressed: showHide,
            icon: Icon(_secureText
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0))
      ),
      style: fontFieldB,
    );

    final loginButton = MaterialButton(child:Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: cgrey(),
            blurRadius: 4,
            offset: Offset(2,4),
            spreadRadius: 2,
          )
        ],
        gradient: LinearGradient(
          colors: [cgreen(),clgreen()],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        )
      ),
      child:AutoSizeText("Login", style: fontButtonw,)
    ), onPressed: () {
         if(_key.currentState.validate()){
            login();
          }
    }
    );

    Widget signupButton(){
      
      return FlatButton(child:Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: cgreen(), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: cgrey(),
            blurRadius: 4,
            offset: Offset(2,4),
            spreadRadius: 2,
          )
        ],
        color: Colors.white,
      ),
      child:AutoSizeText("Sign Up", style: fontButton)
    ), 
    onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpPage(),)
              );
            }
    );}
    final forgotpass = FlatButton(
      child:AutoSizeText('Forgot Password', style: TextStyle(color : Colors.black54),
        ),
        onPressed: (){  
        }, 
      );

    
    final icon = Image(
      width: 200.0,
      image: ficon,
    );
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
            key: _key,
            child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left:24.0,right:24.0),
          children: <Widget>[
            icon,
           AutoSizeText(msg,style: TextStyle(fontFamily: "Calibri", fontSize: 20, color: Colors.red)),
            user,
            SizedBox(height: 8.0,),
            password,
            SizedBox(height: 24.0,),
            loginButton,
            SizedBox(height: 8.0,),
            signupButton(),
            forgotpass,
          ],
        ), 
      ))
    );
    break;
    case LoginStatus.signIn: 
      return MyHomePage(signOut);
      break;
  }
  }
}
class Organization extends StatefulWidget {
  
  @override
  _OrganizationState createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20, // this could be the number of charity organizations so, len..
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
              Sponsors()),);
            },
            child: Image.asset('img/Art.png'),
          ),
        );
      },
    );
  }
}
class Sponsors extends StatefulWidget {

  @override
  _SponsorsState createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount:
          20, // this could be the number of charity organizations so, len..
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              ); */
            },
            child: Image.asset('img/Read.png'),
          ),
        );
      },
    );
  }
}
