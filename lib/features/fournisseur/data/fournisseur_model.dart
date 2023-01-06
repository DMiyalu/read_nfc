class Fournisseur {
  Fournisseur({
    this.name,
    this.shortName,
    this.createdAt,
    this.phone,
    this.email,
    this.nui,
    this.photo,
    this.managerName,
    this.adress,
    this.managementAndOperation,
    this.payment,
    this.supplierCapacity,
  });

  factory Fournisseur.fromJson(Map<String, dynamic> json) {
    return Fournisseur(
      name: json['name'],
      shortName: json['shortName'],
      createdAt: json['createdAt'],
      phone: json['phone'],
      email: json['email'],
      nui: json['nui'],
      photo: json['photo'],
      managerName: json['managerName'],
      adress: json['adress'],
      managementAndOperation: json['managementAndOperation'],
      payment: json['payment'],
      supplierCapacity: json['supplierCapacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'shortName': shortName,
      'createdAt': createdAt,
      'phone': phone,
      'email': email,
      'nui': nui,
      'photo': photo,
      'managerName': managerName,
      'adress': adress,
      'managementAndOperation': managementAndOperation,
      'payment': payment,
      'supplierCapacity': supplierCapacity,
    };
  }

  String? name;
  String? shortName;
  String? createdAt;
  String? phone;
  String? email;
  String? nui;
  String? managerName;
  String? photo;
  Map? adress;
  Map? managementAndOperation;
  Map? payment;
  Map? supplierCapacity;
}
