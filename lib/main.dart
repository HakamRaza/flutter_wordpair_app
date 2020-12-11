import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    // final words = WordPair.random();
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: RandomWords() //call class outside
    );
  }
}

//return class randomState createState
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('WordPair Generators')),
      body:Text('Hello')
    );
  }
}