import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_page.dart'; // Import the login page

void main() {
  runApp(const DiaryApp());
}

class DiaryApp extends StatefulWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  _DiaryAppState createState() => _DiaryAppState();
}

class _DiaryAppState extends State<DiaryApp> {
  // State for dark mode
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary App',
      theme: _isDarkMode
          ? ThemeData.dark()
          : ThemeData(
        primaryColor: Colors.purple[800],
        hintColor: Colors.purpleAccent[400],
        scaffoldBackgroundColor: Colors.purple[50],
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.purple[800]),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.purple[800],
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purpleAccent[400],
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple[800],
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[300]),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.purple[700],
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardColor: Colors.grey[800],
      ),
      home: LoginPage(), // Set LoginPage as the initial screen
    );
  }
}
