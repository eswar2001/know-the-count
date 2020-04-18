import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  Future<List<Country>> _getcountries() async {
    var data = await http.get("https://api.covid19api.com/summary");
    // print(data);

    var jsonData = json.decode(data.body);
// print(jsonData);
    List<Country> countries = [];
 print(jsonData["Countries"]);
    for (var u in jsonData["Countries"]) {
      Country country = Country(
          jsonData["Countries"][u]["Country"],
          jsonData["Countries"][u]["NewConfirmed"],
          jsonData["Countries"][u]["TotalConfirmed"],
          jsonData["Countries"][u]["NewDeaths"],
          jsonData["Countries"][u]["TotalDeaths"],
          jsonData["Countries"][u]["NewRecovered"],
          jsonData["Countries"][u]["TotalRecovered)"]);
      countries.add(country);
    }
    return countries;
  }

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
            // print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
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
}

class DetailPage extends StatelessWidget {
  final Country country;

  DetailPage(this.country);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(country.name),
          Text(' Confirmed ' + country.Confirmed),
          Text('TotalConfirmed ' + country.TotalConfirmed),
          Text('Deaths ' + country.Deaths),
          Text('TotalDeaths ' + country.TotalDeaths),
          Text('Recovered ' + country.Recovered),
          Text('TotalRecovered ' + country.TotalRecovered),
        ],
      ),
    );
  }
}

class Country {
  final String name;
  final String Confirmed;
  final String TotalConfirmed;
  final String Deaths;
  final String TotalDeaths;
  final String Recovered;
  final String TotalRecovered;

  Country(this.name, this.Confirmed, this.TotalConfirmed, this.Deaths,
      this.TotalDeaths, this.Recovered, this.TotalRecovered);
}
