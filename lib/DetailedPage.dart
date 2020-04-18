import 'package:flutter/material.dart';

import 'country.dart';

class DetailPage extends StatelessWidget {
  final Country country;

  DetailPage(this.country);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(country.name),
          Text(' Confirmed  $country.Confirmed'),
          Text('TotalConfirmed  $country.TotalConfirmed'),
          Text('Deaths   $country.Deaths'),
          Text('TotalDeaths  $country.TotalDeaths'),
          Text('Recovered  $country.Recovered'),
          Text('TotalRecovered  $country.TotalRecovered'),
        ],
      ),
    );
  }
}


