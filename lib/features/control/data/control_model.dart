class ControlModel {
  ControlModel(this.description, this.photos);

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
      json['description'],
      json['photos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'photos': photos,
    };
  }

  final String description;
  final List<String> photos;
}
