class Country {
  String name;
  int confirmed;
  int totalConfirmed;
  int deaths;
  int totalDeaths;
  int recovered;
  int totalRecovered;

  Country(this.name, this.confirmed, this.totalConfirmed, this.deaths,
      this.totalDeaths, this.recovered, this.totalRecovered);
  void printdata() {
    print(name);
    print(confirmed);
    print(totalConfirmed);
    print(totalDeaths);
    print(totalRecovered);
  }
}
