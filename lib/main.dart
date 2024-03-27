import 'package:flutter/material.dart';
import 'package:github_search/src/core/init_dependencies.dart';
import 'package:github_search/src/features/favorites/utils/database_connection.dart';
import 'package:github_search/src/features/home/view/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _initializeDB();
  setupGetIt();
  runApp(const MyApp());
}

void _initializeDB() {
  DatabaseConnection.connectDB();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github User List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple, brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}
