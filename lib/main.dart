import 'package:Count/country.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'DetailedPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-count',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'countries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  String s = '';
  bool isSearching = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !isSearching
              ? Text(widget.title)
              : TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Search county here",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
          actions: [
            !isSearching
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = false;
                      });
                    },
                  )
          ]),
      body: Container(
        child: FutureBuilder(
          future: _getcountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text('Null')));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(
                            'https://www.countryflags.io/' +
                                snapshot.data[index].countrycode +
                                '/flat/64.png',
                          ),
                          Text(snapshot.data[index].name),
                          Text(snapshot.data[index].totalConfirmed.toString()),
                          FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(snapshot.data[index])));
                              },
                              child: Text('More Data'))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Country>> _getcountries() async {
    List<Country> countries = [];
    var data = await http.get('https://api.covid19api.com/summary');
    var jsonData = json.decode(data.body);
    // print(jsonData);
    var u;

    for (u = 0; u < 247; u++) {
      Country c = Country(
          jsonData['Countries'][u]['Country'],
          jsonData['Countries'][u]['NewConfirmed'],
          jsonData['Countries'][u]['TotalConfirmed'],
          jsonData['Countries'][u]['NewDeaths'],
          jsonData['Countries'][u]['TotalDeaths'],
          jsonData['Countries'][u]['NewRecovered'],
          jsonData['Countries'][u]['TotalRecovered)'],
          jsonData['Countries'][u]['CountryCode']);
      countries.add(c);
    }
    print("hii");
    return countries;
  }
}
