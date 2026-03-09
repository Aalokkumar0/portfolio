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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 250,
                color: const Color.fromARGB(255, 233, 23, 23),
                child: Center(
                  child: Text(
                    "ScreenBox1",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 250,
              color: const Color.fromARGB(255, 83, 23, 233),
              child: Center(
                child: Text(
                  "ScreenBox2",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 250,
              color: const Color.fromARGB(255, 189, 102, 102),
              child: Center(
                child: Text(
                  "ScreenBox3",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 250,
              color: const Color.fromARGB(255, 87, 188, 44),
              child: Center(
                child: Text(
                  "ScreenBox4",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 240,
                      width: 50,
                      color: const Color.fromARGB(255, 97, 214, 132),
                      child: Center(
                        child: Text(
                          "RowScreenBox1",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 240,
                      width: 50,
                      color: const Color.fromARGB(255, 6, 170, 167),
                      child: Center(
                        child: Text(
                          "RowScreenBox2",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 240,
                      width: 50,
                      color: const Color.fromARGB(255, 134, 134, 203),
                      child: Center(
                        child: Text(
                          "RowScreenBox3",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 240,
                      width: 50,
                      color: const Color.fromARGB(255, 201, 3, 135),
                      child: Center(
                        child: Text(
                          "RowScreenBox4",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
