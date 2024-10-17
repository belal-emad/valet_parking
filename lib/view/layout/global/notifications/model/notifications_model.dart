class NotificationsModel {
  String? type;
  String? id;
  AllData? data;
  String? createdAt;

  NotificationsModel({this.type, this.id, this.data, this.createdAt});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    data = json['data'] != null ? AllData.fromJson(json['data']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class AllData {
  String? title;
  String? text;
  String? redirect;
  String? createdAt;
  int? notificationImage;
  AllData? data;

  AllData(
      {this.title,
      this.text,
      this.redirect,
      this.createdAt,
      this.notificationImage,
      this.data});

  AllData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    redirect = json['redirect'];
    createdAt = json['created_at'];
    notificationImage = json['notification_image'];
    data = json['data'] != null ? AllData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['text'] = text;
    data['redirect'] = redirect;
    data['created_at'] = createdAt;
    data['notification_image'] = notificationImage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? ticketId;

  Data({this.ticketId});

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    return data;
  }
}
