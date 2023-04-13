import 'dart:io';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String cognome;

  @HiveField(2)
  String email;

  @HiveField(3)
  DateTime dataIscrizione;

  @HiveField(4)
  String eta;

  @HiveField(5)
  File profileImage;

  Account(this.nome, this.cognome, this.email, this.dataIscrizione, this.eta,
      this.profileImage);

  String getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  String getCognome() {
    return cognome;
  }

  void setCognome(String cognome) {
    this.cognome = cognome;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  DateTime getDataIscrizione() {
    return dataIscrizione;
  }

  String getEta() {
    return eta;
  }

  File getImageProfile() {
    return profileImage;
  }

  void setImageProfile(File image) {
    profileImage = image;
  }
}
