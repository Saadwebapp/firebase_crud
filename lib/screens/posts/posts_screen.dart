
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/utils/utils.dart';
import 'package:login_signup/widgets/round_button.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  bool loading = false;
  final databseRef = FirebaseDatabase.instance.ref("posts");
  final postContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Posts"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20,),

            TextFormField(
              controller: postContoller,
              maxLines: 4,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                ),
                hintText: "Whats in your mind"
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(title: "Add", onTap: (){
              setState(() {
                loading = true;
              });
              String id =DateTime.now().millisecondsSinceEpoch.toString();
              databseRef.child(id).set({
                "title": postContoller.text.toString(),
                "id" : id,
              }).then((value) {
                Utils().toastMessage("Post Added");
                setState(() {
                  loading =false;
                });
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
              });
            }),
          ],
        ),
      ),
    );
  }
}
