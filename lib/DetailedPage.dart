import 'package:Count/main.dart';
import 'package:flutter/material.dart';

import 'country.dart';

class DetailPage extends StatefulWidget {
  final Country country;

  DetailPage(this.country);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            'https://www.countryflags.io/' +
                widget.country.countrycode +
                '/flat/64.png',
          ),
          Text(widget.country.name + '\n'),
          Text('Confirmed:' + widget.country.confirmed.toString()),
          Text('TotalConfirmed:' + widget.country.totalConfirmed.toString()),
          Text('Deaths:' + widget.country.deaths.toString()),
          Text('TotalDeaths:' + widget.country.totalDeaths.toString()),
          Text('Recovered:' + widget.country.recovered.toString()),
          Text('TotalRecovered:' + widget.country.totalRecovered.toString()),
          FlatButton(
            onPressed: () {
             Mat
            },
            child: Text('Back'),
          )
        ],
      ),
    );
  }
}
