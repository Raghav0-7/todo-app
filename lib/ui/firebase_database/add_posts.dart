import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/utils/utils.dart';
import 'package:untitled1/widgets/round_button.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final titleController =TextEditingController();
  final descriptionController =TextEditingController();
  bool loading = false ;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
       
        
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),

            TextFormField(
              maxLines: 1,
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter title' ,
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 2,
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description' ,
                border: OutlineInputBorder()
              ),
            ),
             SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                  });


                  String id  = DateTime.now().millisecondsSinceEpoch.toString() ;
                  databaseRef.child(id).set({
                    'title' : titleController.text.toString() ,
                    'description':descriptionController.text.toString(),
                    'id' : DateTime.now().millisecondsSinceEpoch.toString()
                  }).then((value){
                    Utils().toastMessage('Added');
                    setState(() {
                      loading = false ;
                    });
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false ;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}
