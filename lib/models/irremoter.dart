class IRremoter {
  final String eq, one, two, three, four, five, six, seven, edge, nine, zero;
  final String ch, chp, chm, prev, next, playpause, volp, volm, twohunp, onehunp;
  IRremoter(this.zero, this.one, this.two, this.three, this.four, this.five, this.six, this.seven, this.edge, this.nine, this.onehunp,this.twohunp, this.volm, this.volp, this.eq, this.prev, this.next, this.playpause, this.chm, this.ch, this.chp);
}

class IRremoteSetting{
  final String name;
  final String describe;
  String value;
  IRremoteSetting(this.name, this.describe, this.value);
}