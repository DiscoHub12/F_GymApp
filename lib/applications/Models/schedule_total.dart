import 'package:gymapp/applications/Models/day_schedule.dart';

class Schedule {
  //Attributes class:
  String nome;
  int numero;
  List<DaySchedule> listaGiorni;

  //Constructor Object:
  Schedule(this.nome, this.listaGiorni, this.numero);

  //Get and Set methods and Other :
  String getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  int getNumero() {
    return numero;
  }

  void setNumero(int numero) {
    this.numero = numero;
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
