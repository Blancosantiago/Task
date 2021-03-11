import 'package:autontificatio/page/LoginPage.dart';
import 'package:autontificatio/page/TaskPage.dart';
import 'package:autontificatio/provider/taskProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, TareasList>(
            update: (context, auth, tareas) => TareasList(
                auth.token, tareas == null ? [] : tareas.items, auth.users)),
      ],
      child: Consumer<Auth>(
        builder: (context, authD, _) => MaterialApp(
          title: 'Todo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent,
          ),
          home: authD.isIn ? Taskpages() : LoginScreen(),
        ),
      ),
    );
  }
}
