import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/ui/auth/phone_auth/verify_code.dart';
import 'package:untitled1/utils/utils.dart';
import 'package:untitled1/widgets/round_button.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false ;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance ;
   TextEditingController countryCode = TextEditingController();
   var phone="";
   @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(height: 80,),

//             Container(
              
//               child: TextFormField(

//                 controller: phoneNumberController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,

//                   hintText: 'Write with Country code +91 45215 62718'
//                 ),
//               ),
//             ),
//             const SizedBox(height: 80,),
//             RoundButton(title: 'Login',loading: loading, onTap: (){

//               setState(() {
//                 loading = true ;
//               });
//               auth.verifyPhoneNumber(
//                 phoneNumber: phoneNumberController.text,
//                   verificationCompleted: (_){
//                     setState(() {
//                       loading = false ;
//                     });
//                   },
//                   verificationFailed: (e){  
//                     setState(() {
//                       loading = false ;
//                     });
//                   Utils().toastMessage(e.toString());
//                   },
//                   codeSent: (String verificationId , int? token){
//                   Navigator.push(context,
//                       MaterialPageRoute(
//                           builder: (context) => VerifyCodeScreen(verificationId:verificationId ,)));
//                   setState(() {
//                     loading = false ;
//                   });
//                   },
//                   codeAutoRetrievalTimeout: (e){
//                     Utils().toastMessage(e.toString());
//                     setState(() {
//                       loading = false ;
//                     });
//                   });
//             })

//           ],
//         ),
//       ),
//     );
//   }
// }
return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      
                        child: TextField(
                          onChanged: (value) {
                            phone=value;
                          },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
auth.verifyPhoneNumber(
                phoneNumber: "${countryCode.text+phone}",
                  verificationCompleted: (_){
                    setState(() {
                      loading = false ;
                    });
                  },
                  verificationFailed: (e){  
                    setState(() {
                      loading = false ;
                    });
                  Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId , int? token){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => VerifyCodeScreen(verificationId:verificationId ,)));
                  setState(() {
                    loading = false ;
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false ;
                    });
                  });

                      
                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}