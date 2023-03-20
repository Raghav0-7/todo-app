import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/ui/auth/phone_auth/login_with_phone_number.dart';
import 'package:untitled1/utils/utils.dart';
import '../../widgets/round_button.dart';
import '../firebase_database/post_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false ;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final  _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }


  void signUp(){
    setState(() {
      loading = true ;
    });
     _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
    
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PostScreen())
      );
      setState(() {
        loading = false ;
      });
    }).onError((error, stackTrace){
      debugPrint(error.toString());
    
      setState(() {
        loading = false ;
      });
    });

    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false ;
      });
    }).onError((error, stackTrace){
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign up')),
       automaticallyImplyLeading: false,
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
                  title: 'Sign up',
                  loading: loading ,
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                       signUp();
                    }
                  },
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
                    },
                        child: Text('Login')),
        
                  ],
                ),
         const SizedBox(height: 30,),
                      InkWell(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  LoginWithPhoneNumber()),
              (route) => false);
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
    );
  }

}
