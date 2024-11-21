import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget userTile({required BuildContext context, required String userName, required String userId, required Color color})
{
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    color: color,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, size: 30,color: Colors.white,),),
      title: Text("$userName", style: TextStyle(color: Colors.white, fontSize: 22),),
    ),
  );
}