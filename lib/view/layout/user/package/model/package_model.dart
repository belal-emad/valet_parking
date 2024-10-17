class PackageModel {
  int? id;
  String? title;
  String? description;
  int? daysStop;
  List<PackagePrices>? packagePrices;
  String? createdAt;

  PackageModel(
      {this.id,
      this.title,
      this.description,
      this.daysStop,
      this.packagePrices,
      this.createdAt});

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    daysStop = json['days_stop'];
    if (json['package_prices'] != null) {
      packagePrices = <PackagePrices>[];
      json['package_prices'].forEach((v) {
        packagePrices!.add(PackagePrices.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['days_stop'] = daysStop;
    if (packagePrices != null) {
      data['package_prices'] =
          packagePrices!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class PackagePrices {
  int? id;
  int? packageId;
  String? name;
  String? noMonth;
  String? price;
  String? createdAt;

  PackagePrices(
      {this.id,
      this.packageId,
      this.name,
      this.noMonth,
      this.price,
      this.createdAt});

  PackagePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    name = json['name'];
    noMonth = json['no_month'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['name'] = name;
    data['no_month'] = noMonth;
    data['price'] = price;
    data['created_at'] = createdAt;
    return data;
  }
}
