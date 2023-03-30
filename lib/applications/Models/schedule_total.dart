import 'package:gymapp/applications/Models/day_schedule.dart';

class Workout {
  //Attributes class:
  String nome;
  int giorni;
  List<DaySchedule> listaGiorni;

  //Constructor Object:
  Workout(this.nome, this.listaGiorni, this.giorni);

  //Get and Set methods and Other :
  String getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  int getNumero() {
    return giorni;
  }

  void setNumero(int numero) {
    giorni = numero;
  }

  List<DaySchedule> getListaGiorni() {
    return listaGiorni;
  }

  void setListaGiorni(List<DaySchedule> listaGiorni) {
    this.listaGiorni = listaGiorni;
  }

  void addGiorno(DaySchedule giorno) {
    listaGiorni.add(giorno);
  }

  void removeGiorno(DaySchedule giorno) {
    listaGiorni.remove(giorno);
  }
}
