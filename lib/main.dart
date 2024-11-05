import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

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
        primaryColor: Colors.purple[800], // Primary color for light theme
        hintColor: Colors.purpleAccent[400], // Hint color for light theme
        scaffoldBackgroundColor: Colors.purple[50], // Background color for light theme
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.purple[800]), // Body text color
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.purple[800], // AppBar color for light theme
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purpleAccent[400], // FAB background color
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white, // Card color for light theme
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple[800], // Primary color for dark theme
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[300]),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.purple[700], // AppBar color for dark theme
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardColor: Colors.grey[800], // Card color for dark theme
      ),
      home: HomeScreen(
        onToggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode; // Toggle dark mode
          });
        },
      ),
    );
  }
}
