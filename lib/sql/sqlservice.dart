import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SQLService{
  static const UrlDatabase="http://charitytime2020.000webhostapp.com/login.php";
  static const UrlDatabaseReg="http://charitytime2020.000webhostapp.com/register.php";
  static const _Login_Account = "Login_Account";
  //Login User

  static Future<String> loginUser(String email, String pass) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'Login_Account';
      map['email'] = email;
      map['pass'] =pass;
      final response = await http.post(UrlDatabase, body:map);
      
      if(200 == response.statusCode){
        return (response.body);
      }
      else{
        print("error");
      }
    }
    catch(e){
      return "Something got wrong";
    }
  }
  static Future<String> regUser(String email, String pass, String uname, String fname, String lname) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'Reg_Account';
      map['email'] = email;
      map['pass'] =pass;
      map['uname'] = uname;
      map['fname'] =fname;
      map['lname'] =lname;
      final response = await http.post(UrlDatabaseReg, body:map);
      print('Adding User: ${response.body}');
      if(200 == response.statusCode){
        return (response.body);
      }
      else{
        return("error");
      }
    }
    catch(e){
      return "Something got wrong";
    }
  }
}