class OnBoardingModel {
  String? firstOnboardingTitle;
  String? firstOnboardingSpecialText;
  String? firstOnboardingDescription;
  String? secondOnboardingTitle;
  String? secondOnboardingSpecialText;
  String? secondOnboardingDescription;
  String? thirdOnboardingTitle;
  String? thirdOnboardingSpecialText;
  String? thirdOnboardingDescription;

  OnBoardingModel(
      {this.firstOnboardingTitle,
      this.firstOnboardingSpecialText,
      this.firstOnboardingDescription,
      this.secondOnboardingTitle,
      this.secondOnboardingSpecialText,
      this.secondOnboardingDescription,
      this.thirdOnboardingTitle,
      this.thirdOnboardingSpecialText,
      this.thirdOnboardingDescription});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    firstOnboardingTitle = json['first_onboarding_title'];
    firstOnboardingSpecialText = json['first_onboarding_special_text'];
    firstOnboardingDescription = json['first_onboarding_description'];
    secondOnboardingTitle = json['second_onboarding_title'];
    secondOnboardingSpecialText = json['second_onboarding_special_text'];
    secondOnboardingDescription = json['second_onboarding_description'];
    thirdOnboardingTitle = json['third_onboarding_title'];
    thirdOnboardingSpecialText = json['third_onboarding_special_text'];
    thirdOnboardingDescription = json['third_onboarding_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_onboarding_title'] = firstOnboardingTitle;
    data['first_onboarding_special_text'] = firstOnboardingSpecialText;
    data['first_onboarding_description'] = firstOnboardingDescription;
    data['second_onboarding_title'] = secondOnboardingTitle;
    data['second_onboarding_special_text'] = secondOnboardingSpecialText;
    data['second_onboarding_description'] = secondOnboardingDescription;
    data['third_onboarding_title'] = thirdOnboardingTitle;
    data['third_onboarding_special_text'] = thirdOnboardingSpecialText;
    data['third_onboarding_description'] = thirdOnboardingDescription;
    return data;
  }
}
