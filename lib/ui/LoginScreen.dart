import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,

      controller: _email,
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async{
         final formState=_formKey.currentState;
         if(formState.validate()){
           print("In");
           formState.save();
           try{
             final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
             print("In");
               AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
                   email: _email.text, password: _password.text);
               FirebaseUser user = result.user;
             print("user  ${user.email}");
             Navigator.push(context, MaterialPageRoute(builder:( context)=>HomeScreen(user: user,)));
             }
           catch(e){
             print(e.message);
           }
         }
         print("out");

        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('SIGN IN', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpLabel = FlatButton(
      child: Text(
        'Create an Account',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder:( context)=>SignUpScreen()));
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
                      loginButton,
                      signUpLabel
            ],
        )))),
    ));
  }
}
