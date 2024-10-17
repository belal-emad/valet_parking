class CategoryModel {
  int? id;
  String? title;
  String? address;
  int? categoryTypeId;
  String? categoryTypeTitle;
  Gates? gates;
  String? createdAt;

  CategoryModel(
      {this.id,
      this.title,
      this.address,
      this.categoryTypeId,
      this.categoryTypeTitle,
      this.gates,
      this.createdAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    categoryTypeId = json['category_type_id'];
    categoryTypeTitle = json['category_type_title'];
    gates = json['gates'] != null ? Gates.fromJson(json['gates']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['address'] = address;
    data['category_type_id'] = categoryTypeId;
    data['category_type_title'] = categoryTypeTitle;
    if (gates != null) {
      data['gates'] = gates!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Gates {
  int? id;
  String? title;
  List<Slots>? slots;
  String? createdAt;

  Gates({this.id, this.title, this.slots, this.createdAt});

  Gates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Slots {
  int? id;
  String? title;
  bool? isFree;
  bool? isUserParked;
  String? createdAt;

  Slots({this.id, this.title, this.isFree, this.isUserParked, this.createdAt});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isFree = json['is_free'];
    isUserParked = json['is_user_parked'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['is_free'] = isFree;
    data['is_user_parked'] = isUserParked;
    data['created_at'] = createdAt;
    return data;
  }
}
