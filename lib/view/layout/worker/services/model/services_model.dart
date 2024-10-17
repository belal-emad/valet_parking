class ServicesModel {
  int? id;
  String? title;
  int? ticketId;
  String? status;
  int? carsNo;
  String? createdAt;
  int? serviceId;

  ServicesModel({
    this.id,
    this.title,
    this.ticketId,
    this.status,
    this.carsNo,
    this.createdAt,
    this.serviceId,
  });

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    ticketId = json['ticket_id'];
    status = json['status'];
    carsNo = json['cars_no'];
    createdAt = json['created_at'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['ticket_id'] = ticketId;
    data['status'] = status;
    data['cars_no'] = carsNo;
    data['created_at'] = createdAt;
    data['service_id'] = serviceId;
    return data;
  }
}
