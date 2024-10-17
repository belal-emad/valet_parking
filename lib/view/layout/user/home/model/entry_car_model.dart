class EntryCarModel {
  int id;
  int categoryTypeId;
  String categoryTypeTitle;
  int categoryId;
  String categoryTitle;
  int gateId;
  String gateTitle;
  int slotId;
  String slotTitle;
  int userId;
  String userName;
  int userCarId;
  String carModel;
  String carColor;
  String carPlate;
  String status;
  String createdAt;
  String ticketQr;
  String userMobile;
  List<String> carImages;
  List<Service> services;

  EntryCarModel({
    required this.id,
    required this.categoryTypeId,
    required this.categoryTypeTitle,
    required this.categoryId,
    required this.categoryTitle,
    required this.gateId,
    required this.gateTitle,
    required this.slotId,
    required this.slotTitle,
    required this.userId,
    required this.userName,
    required this.userCarId,
    required this.carModel,
    required this.carColor,
    required this.carPlate,
    required this.status,
    required this.userMobile,
    required this.createdAt,
    required this.ticketQr,
    required this.carImages,
    required this.services,
  });

  factory EntryCarModel.fromJson(Map<String, dynamic> json) {
    return EntryCarModel(
      id: json['id'],
      categoryTypeId: json['category_type_id'],
      categoryTypeTitle: json['category_type_title'],
      categoryId: json['category_id'],
      categoryTitle: json['category_title'],
      gateId: json['gate_id'],
      gateTitle: json['gate_title'],
      slotId: json['slot_id'],
      slotTitle: json['slot_title'],
      userId: json['user_id'],
      userName: json['user_name'],
      userCarId: json['user_car_id'],
      carModel: json['car_model'],
      userMobile: json['user_mobile'],
      carColor: json['car_color'],
      carPlate: json['car_plate'],
      status: json['status'],
      createdAt: json['created_at'],
      ticketQr: json['ticket_qr'],
      carImages: List<String>.from(json['car_images']),
      services: List<Service>.from(
        json['services'].map((serviceJson) => Service.fromJson(serviceJson)),
      ),
    );
  }
}

class Service {
  int id;
  int serviceId;
  String serviceTitle;
  String createdAt;

  Service({
    required this.id,
    required this.serviceId,
    required this.serviceTitle,
    required this.createdAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceId: json['service_id'],
      serviceTitle: json['service_title'],
      createdAt: json['created_at'],
    );
  }
}
