import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class RedirectionPage extends StatefulWidget{
  const RedirectionPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _RedirectionPageState();
  }
}

class _RedirectionPageState extends State<RedirectionPage> {
  @override
  Widget build(BuildContext context){
    return  StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.connectionState ==  ConnectionState.waiting){
          return const CircularProgressIndicator();
        
        }
        else if (snapshot.hasData){
          return MedicliniquApp();
        }
        else{
          return  LoginScreen();
        }
      }
      );

  }
}