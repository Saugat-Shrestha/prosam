import "package:flutter/material.dart";
import "package:prosam/bloc_view/equatable_testing.dart";
import "package:prosam/bloc_view/login/login_screen.dart";
import "package:prosam/views/home_view.dart";

void main() {
  runApp(const prosam());
}

class prosam extends StatelessWidget {
  const prosam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
