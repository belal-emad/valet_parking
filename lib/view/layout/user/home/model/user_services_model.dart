class UserServicesModel {
  int? id;
  String? title;
  String? description;
  int? price;
  String? createdAt;

  UserServicesModel(
      {this.id, this.title, this.description, this.price, this.createdAt});

  UserServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['created_at'] = createdAt;
    return data;
  }
}
