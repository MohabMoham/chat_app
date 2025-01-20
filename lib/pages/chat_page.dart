import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../widgets/chat bubble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});
   final  _controller = ScrollController();

   CollectionReference messages = FirebaseFirestore.instance.collection('messages');
   TextEditingController controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
   return StreamBuilder<QuerySnapshot>
     (
       stream: messages.orderBy('createdAt',descending: true).snapshots(),
       builder:(context,snapshot) {
         
         if(snapshot.hasData){
           List<Message> messageList = [];
           for(int i = 0 ;i<snapshot.data!.docs.length;i++)
           {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
           }
           return Scaffold(
             appBar: AppBar(
               automaticallyImplyLeading: false,
               backgroundColor: Color(0xff2B475E),
               title: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(
                     'assets/images/scholar.png',
                     height: 50,
                   ),
                   Text(
                     'Chat',
                     style: TextStyle(
                         color: Colors.white
                     ),
                   )

                 ],
               ),
             ),
             body: Column(
               children: [
                 Expanded(
                   child: ListView.builder(
                     reverse: true,
                       controller: _controller,
                       itemCount: messageList.length,
                       itemBuilder: (context, index) {
                         return messageList[index].id ==email? ChatBubble(message: messageList[index]):ChatBubbleForFriend(message: messageList[index]);
                       }),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16),
                   child: TextField(
                     controller: controler,
                     onSubmitted: (data) {
                       messages.add(
                           {
                             "message": data,
                             'createdAt':DateTime.now(),
                             'id' : email,

                           });
                       controler.clear();
                       _controller.animateTo(
                         0,
                         duration: Duration(milliseconds: 500),
                         curve: Curves.easeIn,
                       );
                     },

                     decoration: InputDecoration(
                         suffixIcon: Icon(
                           Icons.send,
                         ),
                         hintText: 'send message',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(16)
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(16),
                             borderSide: BorderSide(
                               color: Color(0xff2B475E),
                             )
                         )
                     ),
                   ),
                 ),

               ],
             ),

           );
         }
         else{
           return Text('loading');
         }
       },
    );
  }
}




