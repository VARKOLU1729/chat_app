import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  const ChatScreen({super.key, required this.userId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final curUserId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController chatTextController = TextEditingController();

  Color color = Color.fromARGB(255, 44, 54, 62);


  String enteredText = "def";
  bool entered = false;

  void _submitMessage(String enteredText) async
  {
    final curUsersnapShot = await FirebaseFirestore.instance.collection('ChatUsers').doc(curUserId).get();
    final curUserName = curUsersnapShot.data()!["userName"];
    final curUserChatContact = await FirebaseFirestore.instance
        .collection('ChatUsers')
        .doc(curUserId).collection('userChatContacts').doc(widget.userId);
    curUserChatContact
        .collection('Chats')
        .add(
        {
          'createdAt': Timestamp.now(),
          'message': enteredText,
          'userId': curUserId,
          'userName':curUserName
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    chatTextController.addListener(() {
      if (chatTextController.text.isNotEmpty) {
        setState(() {
          entered = true;
        });
      } else {
        setState(() {
          entered = false;
        });
      }
    });

    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: Column(
          children: [
            TextButton(
                onPressed: (){}, 
                child: Text("My Profile", style: TextStyle(color: Colors.white),)
            )
          ],
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context)=>IconButton(
              onPressed:(){
                print("Hi");
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white,)),
        ),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
              icon: Icon(Icons.exit_to_app, color: Colors.white,)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('ChatUsers').doc(curUserId).collection('userChatContacts').doc(widget.userId).collection("Chats").orderBy('createdAt', descending: true).snapshots(),
                builder: (context, snapshot)
                {
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
                  var messages = snapshot.data!.docs;

                  return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return textCard(
                            text: messages[index].data()['message'],
                          align : (FirebaseAuth.instance.currentUser!.uid == messages[index].data()['userId']) ? true : false,
                          time: messages[index].data()['createdAt'].toDate().toUtc().toString()
                        );
                      });
                }
            ),
            // child: ListView.builder(
            //     reverse: true,
            //     itemCount: chats.length,
            //     itemBuilder: (context, index) {
            //       return textCard(text: chats[chats.length - index - 1]);
            //     }),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 65,
                child: TextField(
                  cursorColor: Colors.white,
                  controller: chatTextController,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      fillColor: color,
                      filled: true),
                  onChanged: (val) {
                    enteredText = val;
                  },
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: entered ? Colors.green : Colors.green[600]),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _submitMessage(enteredText);
                    setState(() {
                      chatTextController.text = '';
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget textCard({required String text, required bool align, required String time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Align(
        alignment: align ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          // color: Colors.green,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.green),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(color: Colors.white, fontSize: 20),
              children: [
                TextSpan(
                  text: time.substring(10,16),
                  style: TextStyle(color: Colors.white, fontSize: 10)
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}
