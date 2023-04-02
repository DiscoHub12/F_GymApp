import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  String nomeEsercizio;
  @HiveField(1)
  String ripetizioni;
  @HiveField(2)
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
