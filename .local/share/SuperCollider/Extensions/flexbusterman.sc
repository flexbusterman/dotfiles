+ SimpleNumber {

  tempodur {
    var tempo, beatdur;
    tempo = this;
    beatdur = 60/tempo;
    ^beatdur;
  }

  durtempo {
    var beatdur, tempo;
    beatdur = this;
    tempo = 60/beatdur;
    ^tempo;
  }

}
