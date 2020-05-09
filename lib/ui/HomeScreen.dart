
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    final logoutButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async{
            try{
               _firebaseAuth.signOut();
               /*Signs out the current user and clears it from the disk cache.
               updates the [onAuthStateChanged] stream.
                */
              Navigator.push(context, MaterialPageRoute(builder:( context)=>LoginScreen()));
            }
            catch(e){
              print(e.message);
            }

        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('SIGN OUT', style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body:Center(
          child:Column(
            children: <Widget>[
              Text(
                widget.user.email.toString()
              ),
              logoutButton
            ],
          )
        )
    );
  }
}
