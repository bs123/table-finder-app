import 'dart:async';
import 'dart:core';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_udid/flutter_udid.dart';

void main() => runApp(new MyApp());

Future<Post> fetchPost() async {
  final response = await get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
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
  /* Widget bodyData() =>
      DataTable(
          onSelectAll: (b) {},
          sortColumnIndex: 1,
          sortAscending: true,
          columns: <DataColumn>[

            DataColumn(
              label: Text("First Name"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  names.sort((a, b) => a.firstName.compareTo(b.firstName));
                });
              },
              tooltip: "To display first name of the Name",
            ),
            DataColumn(
              label: Text("Last Name"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  names.sort((a, b) => a.lastName.compareTo(b.lastName));
                });
              },
              tooltip: "To display last name of the Name",
            ),
          ],
          rows: names
              .map(
                (name) =>
                DataRow(
                  cells: [
                    DataCell(
                      Text(name.firstName),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(name.lastName),
                      showEditIcon: false,
                      placeholder: false,
                    )
                  ],
                ),
          )
              .toList()); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LeaderBoard"),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.body);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),

        //  child: RaisedButton(
        //       onPressed: () {
        //        Navigator.pop(context);
        //     },
        ///    child: Text('Go back!'),
      ),
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

  Future<Response> fetchFriends() {
    return get('https://jsonplaceholder.typicode.com/posts/');
  }

  String getRank(int spentDays) {
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _rank = getRank(_counter);
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
                  'Wiesnbesuche 2018: $_counter',
                  style: Theme.of(context).textTheme.display2,
                ),
                new Text(
                  'Dein Rang: $_rank',
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
