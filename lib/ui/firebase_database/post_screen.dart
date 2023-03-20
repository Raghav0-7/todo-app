import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ui/auth/login_screen.dart';
import 'package:untitled1/ui/firebase_database/add_posts.dart';
import 'package:untitled1/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  
 
  final searchFilter = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
         
          Expanded(child: StreamBuilder 
          
          (stream: ref.onValue, 
          
           builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
            if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
            }
            else{
              Map<dynamic ,dynamic> map = snapshot.data!.snapshot.value as dynamic;
              List<dynamic> list=[];
              list.clear();
              list= map.values.toList();


              return ListView.builder(
              itemCount: snapshot.data!.snapshot.children.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index]['title']),
                
              );
            },);
            }
            
            
           
          },)),
            ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  AddPostScreen()),
              (route) => true);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

         