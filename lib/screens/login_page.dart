import 'package:diary_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool _isCreatingPin = false; // Track if creating a new PIN

  Future<void> _handlePin() async {
    final String pin = _pinController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPin = prefs.getString('userPin');

    if (_isCreatingPin) {
      // Sign up case
      if (pin.length < 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PIN must be at least 4 digits')),
        );
        return;
      }

      // Save the new PIN
      await prefs.setString('userPin', pin);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PIN created successfully!')),
      );

      // Proceed to the home page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(onToggleTheme: () {  },)),
      );
    } else {
      // Login case
      if (pin == storedPin) {
        // If the PIN matches, navigate to the home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(onToggleTheme: () {  },)),
        );
      } else {
        // If the PIN doesn't match, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid PIN')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isCreatingPin ? 'Create a PIN' : 'Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCreatingPin ? 'Create a new PIN' : 'Enter your PIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _pinController,
                hintText: 'PIN',
                obscureText: true,
              ),
              if (_isCreatingPin)
                Column(
                  children: [
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _confirmPinController,
                      hintText: 'Confirm PIN',
                      obscureText: true,
                    ),
                  ],
                ),
              SizedBox(height: 20),
              CustomButton(
                label: _isCreatingPin ? 'Create PIN' : 'Login',
                onPressed: _handlePin,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isCreatingPin = !_isCreatingPin; // Toggle between login and signup
                    _pinController.clear(); // Clear the PIN input field
                    _confirmPinController.clear(); // Clear the confirm PIN field if switching to login
                  });
                },
                child: Text(
                  _isCreatingPin ? 'Already have a PIN? Login' : 'Create a PIN',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}