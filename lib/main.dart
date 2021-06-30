import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign/models/user.dart';
import 'package:sign/pages/services/auth.dart';
import 'package:sign/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserId>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Firebase Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Warpper(),
      ),
    );
  }
}


