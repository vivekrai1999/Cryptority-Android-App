import 'package:flutter/material.dart';
import 'CeaserCipher.dart';


void main()=>runApp(Cryptority());

class Cryptority extends StatelessWidget {
  const Cryptority({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: CeaserCipher(),
      );
  }
}