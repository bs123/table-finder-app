import 'dart:async';
import 'dart:core';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_udid/flutter_udid.dart';

void main() => runApp(new MyApp());

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Post>> fetchPost() async {
  //final response = await get('http://104.248.136.133:3030/beerChallenge/');
  // final response = await get('http://10.88.103.176:8080/beerChallenge'); // jan
  final response = await get('http://104.248.136.133:3030/beerChallenge');
  return parsePosts(response.body);
}

class Helper {
  static String getRank(int spentDays) {
    String rank = "";

    switch (spentDays) {
      case 1:
        rank = "Private";
        break;
      case 2:
        rank = "Private";
        break;

      case 3:
        rank = "Fähnrich";
        break;
      case 4:
        rank = "Fähnrich";
        break;

      case 5:
        rank = "Leutnant";
        break;
      case 6:
        rank = "Leutnant";
        break;
      case 7:
        rank = "Leutnant";
        break;

      case 8:
        rank = "Commander";
        break;
      case 9:
        rank = "Commander";
        break;
      case 10:
        rank = "Commander";
        break;

      case 11:
        rank = "Captain";
        break;
      case 12:
        rank = "Captain";
        break;
      case 13:
        rank = "Captain";
        break;
      case 14:
        rank = "Captain";
        break;

      case 15:
        rank = "Admiral";
        break;
      case 16:
        rank = "Admiral";
        break;
    }

    return rank;
  }
}

class Post {
  final String id;
  final int date;
  final String name;
  final int daysPresent;

  Post({this.id, this.date, this.name, this.daysPresent});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      date: json['date'],
      name: json['name'],
      daysPresent: json['daysPresent'],
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pink Fluffy Unicorns',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pink Fluffy Unicorn Start Bildschirm'),
    );
  }
}

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LeaderBoard"),
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PostsList(posts: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              /*snapshot.hasData
              ? PostsList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator()); */
            },
          ),
        ));
  }
}

class PostsList extends StatelessWidget {
  final List<Post> posts;

  PostsList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 3.3, ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Text(Helper.getRank(posts[index].daysPresent) + ' ' + posts[index].name + ' war ' + posts[index].daysPresent.toString() + ' Tag(e) anwesend.', style: Theme.of(context).textTheme.display2,);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String _udid = async.await FlutterUdid.consistentUdid;
  String _udid = 'Unknown';
  int _counter = 0;
  String _rank = "";
  String _friends = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.udid;
    } on Exception {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _rank = Helper.getRank(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: ListView(
        children: [
          new Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: new Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug paint" (press "p" in the console where you ran
              // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
              // window in IntelliJ) to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '$_counter Wiesnbesuche 2018',
                  style: Theme.of(context).textTheme.display2,
                ),
                new Text(
                  'Du bist im Rang eines: $_rank',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          new Card(
            //       child: new AssetImage('res/pics/wiesnplan-2018.jpg'),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(
                    Icons.place,
                    color: Colors.green,
                  ),
                  //  leading: const Icon(Icons.place, color: Colors.red,),

                  title: const Text('Anwesend'),
                ),
                new Text('$_udid $_friends'),
                new ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: new ButtonBar(
                    children: <Widget>[
                      new FlatButton(
                        child: const Text('Aktualiseren'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      new FlatButton(
                          child: const Text('LeaderBoard'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeaderBoard()),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'images/wiesnplan-2018.jpg',
            height: 540.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
