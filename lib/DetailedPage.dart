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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
            ),
            Image.network(
              'https://www.countryflags.io/' +
                  widget.country.countrycode +
                  '/flat/64.png',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.country.name + '\n',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Text(
              'Confirmed:' + widget.country.confirmed.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'TotalConfirmed:' + widget.country.totalConfirmed.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'Deaths:' + widget.country.deaths.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'TotalDeaths:' + widget.country.totalDeaths.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'Recovered:' + widget.country.recovered.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'TotalRecovered:' + widget.country.totalRecovered.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
              ),
            ),
            FlatButton(
              color: Colors.grey,
              splashColor: Colors.purple,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
