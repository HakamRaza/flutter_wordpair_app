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
        //need to return something
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

  
  void _pushSaved() {
    // a function, to route new page
    Navigator.of(context).push(
      //route
      MaterialPageRoute(
        builder: (BuildContext context) {
          //create view list of words selected
          final Iterable<ListTile> tiles =
          _savedWords.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle(
                fontSize: 16.0))
            );
          });

          //create dividers for list words selected
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          //return a render
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Words')),
              body:ListView(children: divided));
        }));
  }


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('WordPair Generators'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved, //call function pushSaved
          )
        ],
        ),
      body:_buildList()
    );
  }
}