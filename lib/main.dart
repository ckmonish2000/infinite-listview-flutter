import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Myapp(),
    );
  }
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: random()),
    );
  }
}

class random extends StatefulWidget {
  @override
  _randomState createState() => _randomState();
}

class _randomState extends State<random> {
  ScrollController _scrollController = ScrollController();
  List<String> img = [];
  fetch() async {
    var res = await http.get("https://dog.ceo/api/breeds/image/random");
    if (res.statusCode == 200) {
      var x = jsonDecode(res.body)['message'];
      print(x);
      setState(() {
        img.add(x);
      });
    }
  }

  fetchfive() {
    for (int i = 0; i < 5; i++) {
      fetch();
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchfive();
  //   _scrollController.addListener((){
  //     if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
  //       fetchfive();
  //     }
  //   });
  //     }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  // _scrollController.dispose();
  //   super.dispose();
  
  // }

  // var wordpair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    fetchfive();
    return Container(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: img.length,
            itemBuilder: (context, int i) {
              return Container(
                  child: Image.network(
                    img[i],
                    fit: BoxFit.cover,
                  ),
                  
                  height: 200.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                  ));
            }));
  }
}

// // class test extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: SafeArea(
// //         child: ListView(
// //           padding: EdgeInsets.all(10.0),
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(color: Colors.yellow),
// //               child: Center(
// //                 child: Text("hello"),
// //               ),
// //             ),
// //             Container(
// //               decoration: BoxDecoration(color: Colors.yellow[100]),
// //               child: Center(
// //                 child: Text("hi"),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class test2 extends StatelessWidget {

// //   final List<String> entries = [];
// //   final List<Color> clr = [
// //     Colors.green,
// //     Colors.red,
// //     Colors.yellow,
// //     Colors.grey
// //   ];
// //   @override
// //   Widget build(BuildContext context) {
// //     fetch();
// //     return Container(
// //       child: ListView.separated(
// //         padding: EdgeInsets.all(20.0),
// //         itemCount: entries.length,
// //         itemBuilder: (context, int index) {
// //           return Container(

// //               child: Center(
// //                 child: random(),
// //               ));
// //         },
// //        separatorBuilder: (BuildContext context, int index) => const Divider(),),
// //     );
// //   }
//   fetch(){
//     var jsonData = '{ "name" : "Dane", "alias" : "FilledStacks"  }';
// var parsedJson = json.decode(jsonData)['name'];
// print(' $parsedJson');
//   }
// }
