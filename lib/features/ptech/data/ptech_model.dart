class PtechModel {
  PtechModel(this.name, this.intrants);

  factory PtechModel.fromJson(Map<String, dynamic> json) {
    return PtechModel(
      json['name'],
      json['intrants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'intrants': intrants,
    };
  }

  final String name;
  final List intrants;
}
