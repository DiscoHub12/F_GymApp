import 'dart:ffi';

class Exercise {
  //Attributes class:
  String nomeEsercizio;
  String ripetizioni;
  Double peso;

  //Constructor Object:
  Exercise(this.nomeEsercizio, this.ripetizioni, this.peso);

  //Get and Set Methods : 
  String getNomeEsercizio() {
    return nomeEsercizio;
  }

  void setNomeEsercizio(String nomeEsercizio) {
    this.nomeEsercizio = nomeEsercizio;
  }

  String getRipetizioni() {
    return ripetizioni;
  }

  void setRipetizioni(String ripetizioni) {
    this.ripetizioni = ripetizioni;
  }

  Double getPeso() {
    return peso;
  }

  void setPeso(Double peso) {
    this.peso = peso;
  }
}
