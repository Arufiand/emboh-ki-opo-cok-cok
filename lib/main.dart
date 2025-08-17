import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/pages/first_page.dart';
import 'package:mitch_koko_learning/pages/home_page.dart';
import 'package:mitch_koko_learning/pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void userTapped() {
    print("user Tapped");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: FirstPage(),
      routes: {
        '/firstpage': (context) => FirstPage(),
        '/homePage': (context) => HomePage(),
        '/settingsPage': (context) => SettingsPage(),
      },

      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("My App BarS"),
      //     backgroundColor: Colors.deepPurple,
      //     elevation: 200,
      //     leading: Icon(Icons.menu),
      //     actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      //   ),

      // body: Center(
      //   child: GestureDetector(
      //     onTap: userTapped,
      //     child: Container(
      //       height: 300,
      //       width: 300,
      //       color: Colors.green,
      //       child: Center(child: Text("Tap me")),
      //     ),
      //   ),
      // ),

      // body: Stack(
      //   alignment: Alignment.bottomRight,
      //   children: [
      //     Container(
      //       height: 300,
      //       width: 300,
      //       decoration: BoxDecoration(color: Colors.green),
      //     ),
      //     Container(
      //       height: 200,
      //       width: 200,
      //       decoration: BoxDecoration(color: Colors.green[400]),
      //     ),
      //
      //     Container(
      //       height: 100,
      //       width: 100,
      //       decoration: BoxDecoration(color: Colors.green[200]),
      //     ),
      //   ],
      // ),

      // body: GridView.builder(
      //   itemCount: 64,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 4,
      //   ),
      //   itemBuilder: (context, index) =>
      //       Container(color: Colors.deepPurple, margin: EdgeInsets.all(2)),
      // ),

      // body: ListView(
      //   children: [
      //     Container(
      //       height: 200,
      //       decoration: BoxDecoration(color: Colors.green),
      //     ),
      //     Container(
      //       height: 200,
      //       decoration: BoxDecoration(color: Colors.green[400]),
      //     ),
      //
      //     Container(
      //       height: 200,
      //       decoration: BoxDecoration(color: Colors.green[200]),
      //     ),
      //   ],
      // ),
      // body: Center(
      // child: Container(
      //   height: 300,
      //   width: 300,
      //   decoration: BoxDecoration(
      //     color: Colors.green[500],
      //     borderRadius: BorderRadius.circular(25),
      //   ),
      //   padding: EdgeInsets.all(25),
      //   child: Text(
      //     "Mitch KOko",
      //     style: TextStyle(color: Colors.white, fontSize: 28),
      //   ),
      // ),
      // ),
      // ),
    );
  }
}
