class ProfileModel {
  int? id;
  String? name;
  String? accountType;
  String? countryCode;
  String? mobile;
  String? status;
  String? mobileCode;
  String? profileImage;
  String? mobileVerifiedAt;
  String? valetCategoryId;
  String? valetGateId;
  String? valetCategory;
  String? valetGate;
  String? createdAt;
  String? token;
  bool? hasPackage;
  String? email;
  int? valetOnline;

  ProfileModel({
    this.id,
    this.name,
    this.accountType,
    this.countryCode,
    this.mobile,
    this.status,
    this.mobileCode,
    this.profileImage,
    this.mobileVerifiedAt,
    this.valetCategoryId,
    this.valetGateId,
    this.valetCategory,
    this.valetGate,
    this.createdAt,
    this.token,
    this.hasPackage,
    this.email,
    this.valetOnline,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    accountType = json['account_type'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    status = json['status'];
    mobileCode = json['mobile_code']?.toString();
    profileImage = json['profile_image'];
    mobileVerifiedAt = json['mobile_verified_at'];
    valetCategoryId = json['valet_category_id'].toString();
    valetGateId = json['valet_gate_id'].toString();
    valetCategory = json['valet_category'];
    valetGate = json['valet_gate'];
    createdAt = json['created_at'];
    token = json['token'];
    hasPackage = json['has_package'];
    valetOnline = json['valet_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['account_type'] = accountType;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['status'] = status;
    data['mobile_code'] = mobileCode;
    data['profile_image'] = profileImage;
    data['mobile_verified_at'] = mobileVerifiedAt;
    data['valet_category_id'] = valetCategoryId;
    data['valet_gate_id'] = valetGateId;
    data['valet_category'] = valetCategory;
    data['valet_gate'] = valetGate;
    data['created_at'] = createdAt;
    data['token'] = token;
    data['has_package'] = hasPackage;
    data['valet_online'] = valetOnline;
    return data;
  }
}
