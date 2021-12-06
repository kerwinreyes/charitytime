import 'package:flutter/material.dart';
class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21BFBD),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top:15.0, left:10.0),
          child: Row(children: <Widget>[
            Container(
              width: 125.0,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                IconButton(
                  icon: Icon(Icons.filter_list),
                  color: Colors.white,
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: (){},
                ),
                
              ],)
            )
          ],)
        ),
        SizedBox(height: 40.0,),
        Container(
          height: MediaQuery.of(context).size.height -185.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
          ),
          child: ListView(
            primary:false,
            padding: EdgeInsets.only(left:25.0, right:20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: Container(
                  height: MediaQuery.of(context).size.height -300.0,
                  child: ListView(
                    children:[

                    ],
                  )
                ),
              ),
            ]
          ),
        )
      ],),
    );
  }
}
Widget _buildActivity(String img, String actName, String actDonate){
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right:10.0, top:10.0),
    child: InkWell(
      onTap: (){

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(children:[
              
            ])
          )
      ],),
    ),
    );
}