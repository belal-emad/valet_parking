class CarModel {
  int? id;
  String? carModel;
  String? carColor;
  String? carPlate;
  String? createdAt;

  CarModel(
      {this.id, this.carModel, this.carColor, this.carPlate, this.createdAt});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carPlate = json['car_plate'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['car_model'] = carModel;
    data['car_color'] = carColor;
    data['car_plate'] = carPlate;
    data['created_at'] = createdAt;
    return data;
  }
}
