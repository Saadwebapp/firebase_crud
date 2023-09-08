import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_signup/screens/auth/LoginScreen.dart';
import 'package:login_signup/screens/posts/posts_screen.dart';
import 'package:login_signup/utils/utils.dart';

class HomeScreen extends StatefulWidget {
   String email;
  HomeScreen({Key? key,  this.email= ""}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final auth = FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref("posts");
  final searchController =TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PostsScreen()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Posts"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });

          }, icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 20,),
        ],
      ),
      body: Column(

        children: [
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ) ,
          Expanded(
            child: FirebaseAnimatedList(query: ref, itemBuilder: (context,snapshot, animation,index){
              final title =snapshot.child("title").value.toString();
              if(searchController.text.isEmpty){
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle: Text(snapshot.child("id").value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert_outlined),
                    itemBuilder: (context)=>[
                      PopupMenuItem(
                          value:1,
                          child: ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              showMyDialog(title ,snapshot.child("id").value.toString());

                            },
                        leading: Icon(Icons.edit),
                        title: Text("Edit"),
                      )),
                      PopupMenuItem(
                        onTap: (){
                          ref.child(snapshot.child("id").value.toString()).remove();
                        },
                        value: 1,
                          child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text("Delete"),
                      ))
                    ],
                  ),

                );
              }else if(title.toLowerCase().contains(searchController.text.toLowerCase().toLowerCase())){
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle: Text(snapshot.child("id").value.toString()),

                );
              }else{
                return Container();
              }

            }),
          )
        ],
      )
    );

  }
  Future<void> showMyDialog (String title, id)async{
    editController.text =title;
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                hintText: "Edit Here"
              ),
            ),

          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
            TextButton(onPressed: (){
              Navigator.pop(context);
              ref.child(id).update({
                "title": editController.text.toLowerCase()
              }).then((value) {
                Utils().toastMessage("Post Updated");
              });
            }, child: Text("Update")),
          ] ,
        );
      }
    );
  }
}
//Expanded(child: StreamBuilder(
//           stream: ref.onValue,
//           builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
//
//             if(!snapshot.hasData){
//               return CircularProgressIndicator();
//             }else{
//               Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
//               List<dynamic> list = [];
//               list.clear();
//               list =map.values.toList();
//
//               return ListView.builder(
//                   itemCount: snapshot.data!.snapshot.children.length,
//                   itemBuilder: (
//                       context,index){
//                     return ListTile(
//                       title: Text(list[index]["title"].toString()),
//                       subtitle: Text(list[index]["id"].toString()),
//                     );
//                   });
//             }
//
//           },
//         )),