import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(new MyApp());


final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: new Center(    // Change "const" to "new".
          //child: const Text('Hello World'),   // Replace this text...
            child: new RandomWords(),  // With this text.
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  @override                                  // Add from this line ...
  Widget build(BuildContext context) {
    final List<WordPair> _suggestions = <WordPair>[];
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
    Widget _buildRow(WordPair pair) {
      return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    }
    Widget _buildSuggestions() {
      return new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          // The itemBuilder callback is called once per suggested
          // word pairing, and places each suggestion into a ListTile
          // row. For even rows, the function adds a ListTile row for
          // the word pairing. For odd rows, the function adds a
          // Divider widget to visually separate the entries. Note that
          // the divider may be difficult to see on smaller devices.
          itemBuilder: (BuildContext _context, int i) {
            // Add a one-pixel-high divider widget before each row
            // in the ListView.
            if (i.isOdd) {
              return new Divider();
            }

            // The syntax "i ~/ 2" divides i by 2 and returns an
            // integer result.
            // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
            // This calculates the actual number of word pairings
            // in the ListView,minus the divider widgets.
            final int index = i ~/ 2;
            // If you've reached the end of the available word
            // pairings...
            if (index >= _suggestions.length) {
              // ...then generate 10 more and add them to the
              // suggestions list.
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          }
      );
    };



    return new Scaffold (                   // Add from here...
      body: _buildSuggestions(),
    );  
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
