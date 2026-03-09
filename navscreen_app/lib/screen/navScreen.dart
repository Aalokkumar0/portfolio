import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo nav app"),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Container(
            color: Colors.blue,
            height: 100,
            width: 350,
              child: Center(
                child: Text(
                  "Hi, this is nav page",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            ),
        ),
        ),
    );
  }
}
