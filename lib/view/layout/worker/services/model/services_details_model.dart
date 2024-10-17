class ServicesDetailsModel {
  int? ticketId;
  int? gateId;
  String? gateTitle;
  int? slotId;
  String? slotTitle;
  int? userCarId;
  String? carModel;
  String? carColor;
  String? carPlate;
  String? userMobile;
  String? notes;

  ServicesDetailsModel(
      {this.ticketId,
      this.gateId,
      this.gateTitle,
      this.slotId,
      this.slotTitle,
      this.userCarId,
      this.carModel,
      this.carColor,
      this.carPlate,
      this.userMobile,
      this.notes});

  ServicesDetailsModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    gateId = json['gate_id'];
    gateTitle = json['gate_title'];
    slotId = json['slot_id'];
    slotTitle = json['slot_title'];
    userCarId = json['user_car_id'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carPlate = json['car_plate'];
    userMobile = json['user_mobile'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['gate_id'] = gateId;
    data['gate_title'] = gateTitle;
    data['slot_id'] = slotId;
    data['slot_title'] = slotTitle;
    data['user_car_id'] = userCarId;
    data['car_model'] = carModel;
    data['car_color'] = carColor;
    data['car_plate'] = carPlate;
    data['user_mobile'] = userMobile;
    data['notes'] = notes;
    return data;
  }
}
