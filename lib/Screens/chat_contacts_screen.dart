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

  final firestore = FirebaseFirestore.instance.collection('ChatUsers');
  final curUserId = FirebaseAuth.instance.currentUser!.uid;
  String curUserName = "";
  Map<String, String> userChatContacts = {};


  void getCurUser() async
  {
    var curUserNameTemp = await firestore.doc(curUserId).get();
    setState(() {
      curUserName = curUserNameTemp.data()!['userName'];
    });
  }

  void getUserChatContacts() async
  {
    final inst1 = await firestore.doc(curUserId).collection("userChatContacts").get();
    Map<String, String> tempUserChatContacts = {};
    for(var doc in inst1.docs)
      {
        tempUserChatContacts[doc.id] = doc.data()['userName'];
      }
    setState(() {
      userChatContacts = tempUserChatContacts;
    });
  }

  @override
  void initState()
  {
    super.initState();
    // getCurUser();
    getUserChatContacts();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
              icon: Icon(Icons.exit_to_app, color: Colors.white,)
          )
        ],
        leadingWidth: 200,
        backgroundColor: Colors.black,
        leading: Text("WhatsApp", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
      ),

      body: Stack(
        children: [
          
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: userChatContacts.length,
            itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(userId: userChatContacts.keys.elementAt(index))));
                  },
                    child: chatContact(context:context, userName: userChatContacts.values.elementAt(index), userId: userChatContacts.keys.elementAt(index))
                );
              }
            ),

          Positioned(
            bottom: 16.0, // Distance from the bottom edge
            right: 16.0,  // Distance from the right edge
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: alertDialogContext(),
                      );
                    }
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),



    );
  }

  Widget alertDialogContext()
  {
      return Container(
        width: 200,
         height: 200,
         color: Colors.black87,
         child : StreamBuilder(
              stream: firestore.snapshots(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(color: Colors.orange,)
                    ),
                  );
                }
                var allUsers = snapshot.data!.docs
                    .where((doc) => doc.id != curUserId)
                    .toList();
                return  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allUsers.length,
                    itemBuilder: (context, index){
                      var tempUserName = allUsers[index].data()['userName'];
                      var tempUserId = allUsers[index].id;
                      return InkWell(
                          onTap: () async{
                            var userData = firestore.doc(curUserId);
                            final curUserChatContacts  = userData.collection("userChatContacts");
                            for(var doc in allUsers)
                            {
                              if(doc.id != curUserId)
                                curUserChatContacts.doc(doc.id).set({"userName":doc.data()["userName"]});
                            }
                            getUserChatContacts();
                            Navigator.pop(context);
                          },
                          child: chatContact(context:context, userName: tempUserName, userId: tempUserId)
                      );
                    }
                );
              }
          )
      );
  }

}


Widget chatContact({required BuildContext context, required String userName, required String userId})
{
  return Card(
    margin: EdgeInsets.zero,
    color: Colors.black,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, size: 30,color: Colors.white,),),
      title: Text("$userName", style: TextStyle(color: Colors.white),),
    ),
  );
}
