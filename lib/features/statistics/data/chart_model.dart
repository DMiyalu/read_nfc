class ChartModel {
  ChartModel({this.title, this.maxNumber, this.percent, this.cost});

  factory ChartModel.fromJson(Map<String, dynamic> json) {
    return ChartModel(
      title: json['title'],
      maxNumber: json['maxNumber'],
      percent: json['percent'],
      cost: json['cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'maxNumber': maxNumber,
      'percent': percent,
      'cost': cost,
    };
  }

  String? title;
  double? maxNumber;
  String? percent;
  List<double>? cost;
}
