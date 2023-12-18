import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';
import 'package:netflix_clone/screens/navscreen_page.dart';

import '../assets.dart';


class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState  extends State<RegisterScreen>{
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int _selectedIndex=0;
   String errorMessage="";

  SignIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavScreenPage()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be incorrect.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Please try again";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage,
          gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      body:IndexedStack(
        index: _selectedIndex,
        children: [
          _renderSignIn(),
          _renderSignUp()
        ],
      )
    );

  }
  Widget _renderSignIn(){
    return isLoading?Center(child:
    CircularProgressIndicator(color: Colors.red,
      strokeWidth: 2.0,),):
    Container(
      padding: EdgeInsets.fromLTRB(60,0,60,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(Assets.netflixLogo1,width: 150,),

              Column(
                children: [
                  Text("Welcome",style: GoogleFonts.lato(color: Colors.white38,fontSize: 24),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Let's Discover\nyour next movie",style: GoogleFonts.lato(color: Colors.white38,fontSize: 16,),maxLines: 2,),

                ],
              ),








            ],
          ),


          const SizedBox(height: 60,),
          TextField(
            style: TextStyle(color: Colors.white70),
            controller: emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor:  Color(0xff251546),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white38),
                floatingLabelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.white70),

            controller: passwordController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor:  Color(0xff251546),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white38),

                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
            ),

          ),
          SizedBox(height: 20.0,),

          SizedBox(
            width: 200,
            child: OutlinedButton(

                style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: BorderSide(color: Colors.white38,width: 1.0,),
                  shape: StadiumBorder()


            ),
                onPressed: ()  {
           SignIn();
                },child: Text("Sign in",
                  style: GoogleFonts.lato(fontSize: 18,
                      color: Colors.white70,fontWeight: FontWeight.w600),)),
          ),
          const SizedBox(height: 40,),
          MaterialButton(
            child: Text("Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white),),
            onPressed: (){
              setState((){
                _selectedIndex=1;
              });
            },
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            child: Text("Forgot your password",
              style: TextStyle(color: Colors.white),),
            onPressed: () async {
              print("forgot password");
            },
          ),
        ],
      ),
    );
  }
  Widget _renderSignUp(){
    return Container(
      padding: EdgeInsets.fromLTRB(60,0,60,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(Assets.netflixLogo1,width: 150,),

              Column(
                children: [
                  Text("Welcome",style: GoogleFonts.lato(color: Colors.white38,fontSize: 24),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Let's Discover\nyour next movie",style: GoogleFonts.lato(color: Colors.white38,fontSize: 16,),maxLines: 2,),

                ],
              ),



            ],
          ),
          const SizedBox(height: 60,),
          TextField(
            style: TextStyle(color: Colors.white70),
            controller: nameController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor:  Color(0xff251546),
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.white38),
                floatingLabelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.white70),
            controller: emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor:  Color(0xff251546),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white38),
                floatingLabelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.white70),
            controller: passwordController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor:  Color(0xff251546),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white38),
                floatingLabelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          SizedBox(height: 20.0,),

          SizedBox(
            width: 180,
            child: OutlinedButton(style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: BorderSide(color: Colors.white38,width: 1.0),
              shape: StadiumBorder(),
            ),
                onPressed: () async {
                  final user = _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  if(user != null){
                    setState(()=> _selectedIndex=0);
                  }
                },

                child:  Text("Sign Up",
                  style: GoogleFonts.lato(color: Colors.white70,
                      fontSize: 18,fontWeight: FontWeight.w600))),
          ),
          const SizedBox(height: 40,),
          MaterialButton(
            child: Text("Already have an account? Sign in",
              style: TextStyle(color: Colors.white),),
            onPressed: (){
              setState(()=> _selectedIndex=0);
            },
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}