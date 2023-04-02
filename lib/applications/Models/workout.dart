import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 3)
class Workout extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  int giorni;

  @HiveField(2)
  List<DaySchedule> listaGiorni;

  //Constructor Object:
  Workout(this.nome, this.giorni, this.listaGiorni);

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
