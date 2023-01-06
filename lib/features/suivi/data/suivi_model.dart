class SuiviModel {
  SuiviModel(this.description, this.photos);

  factory SuiviModel.fromJson(Map<String, dynamic> json) {
    return SuiviModel(
      json['text'],
      json['photos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': description,
      'photos': photos,
    };
  }

  final String description;
  final List photos;
}
