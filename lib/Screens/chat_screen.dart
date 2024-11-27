import 'package:chat_app/Widgets/userTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  const ChatScreen({super.key, required this.userId, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final curUserId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController chatTextController = TextEditingController();

  Color color = Color.fromARGB(255, 44, 54, 62);


  String enteredText = "def";
  bool entered = true;

  void _submitMessage(String enteredText) async
  {
    final curUsersnapShot = await FirebaseFirestore.instance.collection('ChatUsers').doc(curUserId).get();
    final curUserName = curUsersnapShot.data()!["userName"];

    //add message in senders chat
    final sender = await FirebaseFirestore.instance
        .collection('ChatUsers')
        .doc(curUserId).collection('userChatContacts').doc(widget.userId);
    sender
        .collection('Chats')
        .add(
        {
          'createdAt': Timestamp.now(),
          'message': enteredText,
          'userId': curUserId,
          'userName':curUserName
        }
    );

    //add message in the receivers chat
    final receiver= await FirebaseFirestore.instance
        .collection('ChatUsers')
        .doc(widget.userId).collection('userChatContacts').doc(curUserId);
    receiver
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
      if (chatTextController.text.isEmpty) {
        setState(() {
          entered = false;
        });
      }
      else if(chatTextController.text.length==1)
        {
          setState(() {
            entered = true;
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
      backgroundColor: Color.fromARGB(255, 12, 20, 26),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 50,
        backgroundColor: Color.fromARGB(255, 31 ,44, 51),
        title: userTile(context: context, userName: widget.userName, userId: widget.userId, color:Color.fromARGB(255, 31 ,44, 51)),
        leading: Builder(
          builder: (context)=>IconButton(
            padding: EdgeInsets.zero,
              onPressed:(){
                print("Hi");
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,)),
        ),
        // actions: [
        //   IconButton(onPressed: (){
        //     FirebaseAuth.instance.signOut();
        //   },
        //       icon: Icon(Icons.exit_to_app, color: Colors.white,)
        //   )
        // ],
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
            height: 7,
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
                    contentPadding: EdgeInsets.only(left: 20),
                    hintStyle: TextStyle(color: Colors.white38),
                      hintText: "Message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      fillColor: Color.fromARGB(255, 31, 39, 42),
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
              borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 1, 92, 75)),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(color: Colors.white, fontSize: 22),
              children: [
                TextSpan(
                  text: "   ${time.substring(10,16)}",
                  style: TextStyle(color: Color.fromARGB(255, 185, 232, 208), fontSize: 12)
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}
