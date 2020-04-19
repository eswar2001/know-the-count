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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle:
                        Text(snapshot.data[index].totalConfirmed.toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
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
          jsonData['Countries'][u]['TotalRecovered)']);
      countries.add(c);
    }
    print("hii");
    return countries;
  }
}
