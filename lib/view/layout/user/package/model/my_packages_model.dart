class MyPackagesModel {
  int? id;
  int? packageId;
  String? packageTitle;
  String? isPaid;
  int? daysStopped;
  String? status;
  int? packagePriceId;
  int? packageNoMonth;
  String? createdAt;
  String? expireAt;
  int? noUsed;

  MyPackagesModel(
      {this.id,
      this.packageId,
      this.packageTitle,
      this.isPaid,
      this.daysStopped,
      this.status,
      this.packagePriceId,
      this.packageNoMonth,
      this.createdAt,
      this.expireAt,
      this.noUsed});

  MyPackagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    packageTitle = json['package_title'];
    isPaid = json['is_paid'];
    daysStopped = json['days_stopped'];
    status = json['status'];
    packagePriceId = json['package_price_id'];
    packageNoMonth = json['package_no_month'];
    createdAt = json['created_at'];
    expireAt = json['expire_at'];
    noUsed = json['no_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['package_title'] = packageTitle;
    data['is_paid'] = isPaid;
    data['days_stopped'] = daysStopped;
    data['status'] = status;
    data['package_price_id'] = packagePriceId;
    data['package_no_month'] = packageNoMonth;
    data['created_at'] = createdAt;
    data['expire_at'] = expireAt;
    data['no_used'] = noUsed;
    return data;
  }
}
