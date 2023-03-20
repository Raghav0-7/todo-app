import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/ui/auth/phone_auth/login_with_phone_number.dart';
import 'package:untitled1/ui/auth/signup_screen.dart';
import 'package:untitled1/ui/firebase_database/add_posts.dart';
import 'package:untitled1/ui/fogot_password.dart';

import 'package:untitled1/utils/utils.dart';

import '../../widgets/round_button.dart';
import '../firebase_database/post_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false ;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

   

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  void login(){
    setState(() {
      loading = true ;
    });
    auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PostScreen())
      );

      setState(() {
        loading = false ;
      });
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false ;
      });
    });
  }

Future<UserCredential?> signInWithGoogle() async {
    // Create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //Triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //Create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          
          title: Center(child: Text('Login')),
          
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const  InputDecoration(
                                hintText: 'Email',
                                 
                                prefixIcon: Icon(Icons.alternate_email)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter email';
                              }
                              return null ;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: true,
                            decoration: const  InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_open)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter password';
                              }
                              return null ;
                            },
                          ),
          
                        ],
                      )
                  ),
                  const SizedBox(height: 50,),
                  RoundButton(
                    title: 'Login',
                    loading: loading,
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        login();
                      
                      }
                   },
                 ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => ForgotPasswordScreen())
                      );
                    },
                        child: Text('Forgot Password?')),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(onPressed: (){
                       Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  SignUpScreen()),
              (route) => false);
                      },
                          child: Text('Sign up'))
                    ],
                  ),
                  const SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginWithPhoneNumber()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.black
                          )
                      ),
                      child: Center(
                        child: Text('Login with Phone'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  InkWell(
                    onTap: ()async{
                    await signInWithGoogle();
                    if(mounted){
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PostScreen()));
                    }
                    },
          
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.black
                          )
                      ),
                      child: Center(
                        child: Text('Login with Google'),
                      ),
                    ),
                  )
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
