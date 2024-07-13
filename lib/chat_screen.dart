import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/message_screen.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.name,
  });
  final String name;
  TextEditingController controller = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: MessageScreen(name: name)),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  onSaved: (value) {
                    controller.text = value!;
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Messege",
                    contentPadding:
                        const EdgeInsets.only(top: 15, left: 8, right: 8),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    return null;
                  },
                )),
                IconButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        firestore.collection("Messages").doc().set({
                          "message": controller.text,
                          "time": DateTime.now(),
                        });
                        controller.clear();
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
