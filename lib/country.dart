class Country {
   String name;
   int Confirmed;
   int TotalConfirmed;
   int Deaths;
   int TotalDeaths;
   int Recovered;
   int TotalRecovered;

  Country(this.name, this.Confirmed, this.TotalConfirmed, this.Deaths,
      this.TotalDeaths, this.Recovered, this.TotalRecovered);
  void printdata() {
    print(name);
    print(Confirmed);
    print(TotalConfirmed);
    print(TotalDeaths);
    print(TotalRecovered);
  }
}