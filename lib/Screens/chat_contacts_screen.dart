import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_screen.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {

  // final firestore = FirebaseFirestore.instance.collection('ChatUsers');
  // final curUserId = FirebaseAuth.instance.currentUser!.uid;
  // String curUserName = "";
  //
  //
  // void getCurUser() async
  // {
  //   var curUserNameTemp = await firestore.doc(curUserId).get();
  //   setState(() {
  //     curUserName = curUserNameTemp.data()!['userName'];
  //   });
  // }

  List<String> contacts = ["vvk1", 'vvk2', 'vvk3', 'vvk4', 'vvk5'];

  @override
  void initState()
  {
    super.initState();
    // getCurUser();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 200,
        backgroundColor: Colors.black,
        leading: Text("WhatsApp", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
      ),
      // body : StreamBuilder(
      //     stream: firestore.doc(curUserId).collection("userChatContacts").snapshots(),
      //     builder: (context, snapshot){
      //       if(snapshot.connectionState == ConnectionState.waiting)
      //       {
      //         return Center(
      //           child: SizedBox(
      //               width: 40,
      //               height: 40,
      //               child: CircularProgressIndicator(color: Colors.orange,)
      //           ),
      //         );
      //       }
      //       var userContactsDocs = snapshot.data!.docs;
      //       return  ListView.builder(
      //         itemCount: userContactsDocs.length,
      //           itemBuilder: (context, index){
      //             var userContactsName = userContactsDocs[index].data()['userName'];
      //             var userContactsUserId = userContactsDocs[index].id;
      //             return chatContact(context:context, userName: userContactsName, userId: userContactsUserId);
      //           }
      //       );
      //     }
      // )

      body: ListView.builder(
        padding: EdgeInsets.zero,

          itemCount: 5,
          itemBuilder: (context, index){
            return chatContact(context:context, userName: contacts[index], userId: contacts[index]);
          }
      ),

    );
  }
}


Widget chatContact({required BuildContext context, required String userName, required String userId})
{
  return InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(userId: userId)));
    },
    child: Card(
      margin: EdgeInsets.zero,
      color: Colors.black,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, size: 30,color: Colors.white,),),
        title: Text("$userName", style: TextStyle(color: Colors.white),),
      ),
    ),
  );
}
