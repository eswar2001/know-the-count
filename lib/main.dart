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
  List<Country> countries = [];
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
              for (var i in countries) print(i);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].TotalConfirmed),
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
    var data = await http.get('https://api.covid19api.com/summary');
    // print(data);
    var jsonData = json.decode(data.body);
// print(jsonData);

//  print(jsonData['Countries'][10]['Country']);

    for (var u in jsonData['Countries']) {
      // print(jsonData['Countries'][u]['Country']);
      Country c = Country(
          jsonData['Countries'][u]['Country'],
          jsonData['Countries'][u]['NewConfirmed'] as int,
          jsonData['Countries'][u]['TotalConfirmed'] as int,
          jsonData['Countries'][u]['NewDeaths'] as int,
          jsonData['Countries'][u]['TotalDeaths'] as int,
          jsonData['Countries'][u]['NewRecovered'] as int,
          jsonData['Countries'][u]['TotalRecovered)'] as int);
      c.printdata();
      countries.add(c);
      // print(countries.length);
    }

    return countries;
  }
}

