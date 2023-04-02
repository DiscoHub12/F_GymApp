import 'dart:ffi';

class Exercise {
  //Attributes class:
  String nomeEsercizio;
  String ripetizioni;
  double peso;

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

  double getPeso() {
    return peso;
  }

  void setPeso(double peso) {
    this.peso = peso;
  }
}
