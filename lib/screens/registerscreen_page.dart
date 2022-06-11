import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  SignIn() async {
    print(('Error'));
    setState((){
      isLoading = true;
    });
    print(isLoading);
    final user = await _auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    if(user != null){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> NavScreenPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return  Container(
      padding: EdgeInsets.fromLTRB(60,0,60,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(Assets.netflixLogo1,width: 200,),
          ),
          const SizedBox(height: 60,),
          TextField(
            controller: emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Email",
                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),
          ),
          TextField(
            controller: passwordController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Password",
                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),

          ),
          SizedBox(height: 20.0,),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: BorderSide(color: Colors.grey,width: 1.0)
            ),
                onPressed: ()  {
              SignIn();
                  isLoading? CircularProgressIndicator:null;
                },child: const Text("Sign in",
                  style: TextStyle(color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),)),
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
          Center(
            child: Image.asset(Assets.netflixLogo1,width: 200,),
          ),
          const SizedBox(height: 60,),
          TextField(
            controller: nameController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Name",
                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),
          ),
          TextField(
            controller: emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Email",
                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),
          ),
          TextField(
            controller: passwordController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Password",
                floatingLabelStyle: TextStyle(color: Colors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),

          ),
          SizedBox(height: 20.0,),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: BorderSide(color: Colors.grey,width: 1.0)
            ),
                onPressed: () async {
                  final user = _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  if(user != null){
                    setState(()=> _selectedIndex=0);
                  }
                },

                child: const Text("Sign Up",
                  style: TextStyle(color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),)),
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
}