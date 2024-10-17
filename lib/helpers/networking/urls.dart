class Urls {
  static const String testBlueCarImage =
      'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&amp;dl=pexels-mike-b-170811.jpg&amp;fm=jpg';
  static const String testWhiteCarImage =
      'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg?cs=srgb&amp;dl=pexels-mike-b-116675.jpg&amp;fm=jpg';
  static const String testCarLogoImage =
      'https://cdn.worldvectorlogo.com/logos/bmw-logo.svg';
  static const String testUserImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLlsHCzHU2GndYsMJQscyixYSlDVggHDzbXtXSuEmLAc309Z-6e1TUhHJFCLCw40Kicw0';
  static const String testAppleLogo =
      'https://justcreative.com/wp-content/uploads/2022/01/Apple-Logo-600x400.png';
  static const String testNoonLogo =
      'https://www.elmin7a.com/wp-content/uploads/2021/08/noon-egypt-jobs-customer-service-agent.png';
  static const String testVideo =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  static const String baseUrl =
      'https://backend.smartvision4p.com/valet_parking/public/api';
  static const String login = '$baseUrl/user/login';
  static const String register = '$baseUrl/user/register';
  static const String logout = '$baseUrl/user/user-logout';
  static const String changePassword = '$baseUrl/user/change-password';
  static const String profile = '$baseUrl/user/profile';
  static const String onBoarding = '$baseUrl/about-main';
  static const String setting = '$baseUrl/setting';
  static const String registerSMS = '$baseUrl/user/access_sms';
  static const String packages = '$baseUrl/packages';
  static const String categoryTypes = '$baseUrl/category_types';
  static const String categories = '$baseUrl/categorys';
  static const String myCar = '$baseUrl/user/cars/index';
  static const String addNewCar = '$baseUrl/user/cars/create';
  static const String cars = '$baseUrl/user/cars/';
  static const String parkingDetails = '$baseUrl/gates?type=';
  static const String services = '$baseUrl/services';
  static const String servicesCategory = '$baseUrl/services?category=';
  static const String entryCar = '$baseUrl/user/tickets/create';
  static const String userTickets = '$baseUrl/user/tickets';
  static const String userTicketId = '$baseUrl/user/tickets/';
  static const String exitTicket = '$baseUrl/user/tickets/';
  static const String requestServices = '$baseUrl/valet/request/service';
  static const String pendingServices = '$baseUrl/valet/services?=';
  static const String servicesDetails = '$baseUrl/valet/services/';
  static const String subscribeToPackage = '$baseUrl/user/user_packages/create';
  static const String myPackages = '$baseUrl/user/user_packages';
  static const String entryCarServices = '$baseUrl/valet/entry/orders';
  static const String exitCarServices = '$baseUrl/valet/receipt/orders';
  static const String tickets = '$baseUrl/user/tickets';
  static const String createTicket = '$baseUrl/user/tickets/create';
  static const String entryCodeNewCar = '$baseUrl/valet/entry/car';
  static const String exitCodeDeliveryCar = '$baseUrl/valet/exit/car';
  static const String dayStopped = '$baseUrl/user/user_packages/';
  static const String valetOnline = '$baseUrl/valet/store-tracker';
  static const String notifications = '$baseUrl/notifications';
  static const String createScanRequest = '$baseUrl/valet/tickets/create';
  static const String userTicketsFinished = '$baseUrl/user/tickets-finished';
  static const String exitTicketRequest = '$baseUrl/user/tickets/';
  static const String postService = '$baseUrl/user/request/service';
  static const String forgetPass = '$baseUrl/user/forget_pass';
}
