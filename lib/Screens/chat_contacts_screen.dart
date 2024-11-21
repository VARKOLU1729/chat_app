import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/userTile.dart';
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
      backgroundColor: Color.fromARGB(255, 31 ,44, 51),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
              icon: Icon(Icons.exit_to_app, color: Colors.white,)
          )
        ],
        leadingWidth: 200,
        backgroundColor: Color.fromARGB(255, 31 ,44, 51),
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("WhatsApp", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [

            Column(
              children: [

                searchContactsBar(),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: userChatContacts.length,
                    itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(userName: userChatContacts.values.elementAt(index),userId: userChatContacts.keys.elementAt(index))));
                          },
                            child: userTile(context:context, userName: userChatContacts.values.elementAt(index), userId: userChatContacts.keys.elementAt(index), color: Color.fromARGB(255, 31 ,44, 51))
                        );
                      }
                    ),
                ),
              ],
            ),

            Positioned(
              bottom: 16.0, // Distance from the bottom edge
              right: 16.0,  // Distance from the right edge
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("All Contacts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          actions: [
                            FilledButton(
                                onPressed: (){Navigator.pop(context);},
                                child: Text("Cancel"),
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                            )
                          ],
                          backgroundColor: Color.fromARGB(255, 31 ,44, 51),
                          content: alertDialogContext(),
                        );
                      }
                  );
                },
                child: Icon(Icons.add, size: 30,color: Colors.black,),
              ),
            ),
          ],
        ),
      ),



    );
  }

  Widget alertDialogContext()
  {
      return Container(
        width: 200,
         height: 200,
         color: Color.fromARGB(255, 31 ,44, 51),
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
                          child: userTile(context:context, userName: tempUserName, userId: tempUserId, color: Color.fromARGB(255, 31 ,44, 51))
                      );
                    }
                );
              }
          )
      );
  }

}


Widget searchContactsBar()
{
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: SizedBox(
      height: 50,
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          hintText: "Search Contacts",
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)),
            fillColor: Color.fromARGB(255, 44, 54, 62),
            filled: true),
      ),
    ),
  );
}




