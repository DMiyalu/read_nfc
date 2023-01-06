class Producteur {
  Producteur(this.name, this.nui, this.sexe, this.birthday, this.phone, this.householdSize, this.length, this.lenght, this.altitude);

  factory Producteur.fromJson(Map<String, dynamic> json) {
    return Producteur(
      json['nui'],
      json['name'],
      json['sexe'],
      json['birthday'],
      json['phone'],
      json['householdSize'],
      json['length'],
      json['lenght'],
      json['altitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nui': nui,
      'sexe': sexe,
      'birthday': birthday,
      'phone': phone,
      'householdSize': name,
      'length': name,
      'lenght': name,
      'altitude': name,
    };
  }

  final String nui;
  final String name;
  final String sexe;
  final String birthday;
  final String phone;
  final String householdSize;
  final String length;
  final String lenght;
  final String altitude;
}
