class ParkingModel {
  int? id;
  String? title;
  List<Slots>? slots;
  String? createdAt;

  ParkingModel({this.id, this.title, this.slots, this.createdAt});

  ParkingModel.fromJson(Map<String, dynamic> json) {
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
