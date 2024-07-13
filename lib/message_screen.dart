import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.name});
  final String name;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Stream<QuerySnapshot> messagestream = FirebaseFirestore.instance
      .collection("Messages")
      .orderBy("time")
      .snapshots();
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: messagestream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.black,
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot data = snapshot.data!.docs[index];
                    return Column(
                      crossAxisAlignment: widget.name != " "
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(4),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(data["message"]),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
