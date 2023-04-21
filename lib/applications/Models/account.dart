import 'dart:typed_data';
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
  DateTime dataNascita;

  @HiveField(5)
  Uint8List profileImage;

  Account(this.nome, this.cognome, this.email, this.dataIscrizione,
      this.dataNascita, this.profileImage);

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

  DateTime getEta() {
    return dataNascita;
  }

  Uint8List getImageProfile() {
    return profileImage;
  }

  void setImageProfile(Uint8List image) {
    profileImage = image;
  }
}
