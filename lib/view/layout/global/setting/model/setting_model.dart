class SettingModel {
  String? email;
  String? mobile;
  String? privacyAr;
  String? privacyEn;

  SettingModel({this.email, this.mobile, this.privacyAr, this.privacyEn});

  SettingModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    privacyAr = json['privacy_ar'];
    privacyEn = json['privacy_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile'] = mobile;
    data['privacy_ar'] = privacyAr;
    data['privacy_en'] = privacyEn;
    return data;
  }
}
