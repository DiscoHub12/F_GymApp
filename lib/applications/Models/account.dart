import 'dart:io';

class Account {
  String nome;
  String cognome;
  String email;
  DateTime dataIscrizione;
  DateTime eta;
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

  DateTime getEta() {
    return eta;
  }

  File getImageProfile() {
    return profileImage;
  }

  void setImageProfile(File image) {
    profileImage = image;
  }
}
