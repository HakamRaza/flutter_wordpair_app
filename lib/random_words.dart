import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


//return class randomState createState
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  //parse wordpair to array []
  final _randomWords = <WordPair>[];
  final _savedWords = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();

        //calculate number of wordpair minus divider
        final index = item ~/ 2;

        //generate new word as we scroll down
        if(index >= _randomWords.length) {
          _randomWords.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWords[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWords.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, 
      style: TextStyle(fontSize: 18.0)),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border, 
        color: alreadySaved ? Colors.red : Colors.yellow
      ),
      onTap: () { //function tigger when clicked
        setState(() {
          if(alreadySaved){
            _savedWords.remove(pair); //removed from state
          } else {
            _savedWords.add(pair); //add to state
          }
        });
      },
      );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('WordPair Generators')),
      body:_buildList()
    );
  }
}