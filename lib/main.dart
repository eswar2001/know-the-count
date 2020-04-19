import 'package:Count/country.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DetailedPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 7),
            Text(
              'Made With',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 7),
            Icon(Icons.favorite, color: Colors.pinkAccent),
            SizedBox(width: 7),
            Text(
              'Flutter',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-count',
      theme: ThemeData.dark(),
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
  bool isSearching = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[800],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.8,
        title: !isSearching
            ? Text('All Countries')
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Country Here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(
                      () {
                        this.isSearching = false;
                        filteredCountries = countries;
                      },
                    );
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(
                      () {
                        this.isSearching = true;
                      },
                    );
                  },
                )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getcountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text('Hang on tight...')));
            } else {
              return filteredCountries.length > 0
                  ? !isSearching
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 5.0,
                                shadowColor: Colors.pink[400],
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://www.countryflags.io/' +
                                          snapshot.data[index].countrycode +
                                          '/flat/64.png',
                                    ),
                                    Text(snapshot.data[index].name + '\n'),
                                    Text('Total confirmed cases:' +
                                        snapshot.data[index].totalConfirmed
                                            .toString()),
                                    FlatButton(
                                        color: Colors.blueGrey,
                                        splashColor: Colors.pink[400],
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(snapshot
                                                          .data[index])));
                                        },
                                        child: Text('More Data'))
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: filteredCountries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(filteredCountries[index]),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Text(
                                    filteredCountries[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }
          },
        ),
      ),
    );
  }

  List<Country> countries = [];
  List<Country> filteredCountries = [];
  @override
  void initState() {
    _getcountries().then((data) {
      setState(() {
        countries = filteredCountries = data;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<List<Country>> _getcountries() async {
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
    // print("hii");
    return countries;
  }
}
