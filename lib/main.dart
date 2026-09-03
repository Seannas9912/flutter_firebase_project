import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb 
        ? const FirebaseOptions(
            apiKey: "AIzaSyCQ2WsTiM-KvSEKlpP-qdLeB7uRbY80UKw",
            appId: "1:632413168619:web:d78871c041140a8c9a6fae",
            messagingSenderId: "632413168619",
            projectId: "todo-app-7612f",
            authDomain: "todo-app-7612f.firebaseapp.com",
            storageBucket: "todo-app-7612f.firebasestorage.app",
          )
        : null, 
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
