import 'package:flutter/material.dart';
import 'package:valet_parking/view/layout/user/reservations/screen/entering_car_qr_code_screen.dart';

import '../../view/custom_widgets/zoom_image/zoom_image_screen.dart';
import '../../view/layout/global/auth/screen/change_password_screen.dart';
import '../../view/layout/global/auth/screen/forgot_password_otp_screen.dart';
import '../../view/layout/global/auth/screen/forgot_password_screen.dart';
import '../../view/layout/global/auth/screen/login_screen.dart';
import '../../view/layout/global/auth/screen/new_password_screen.dart';
import '../../view/layout/global/auth/screen/register_screen.dart';
import '../../view/layout/global/auth/screen/register_through_screen.dart';
import '../../view/layout/global/auth/screen/registration_otp_screen.dart';
import '../../view/layout/global/auth/screen/registration_screen.dart';
import '../../view/layout/global/notifications/screen/notifications_screen.dart';
import '../../view/layout/global/on_boarding/screen/choose_lang_screen.dart';
import '../../view/layout/global/on_boarding/screen/on_boarding_screen.dart';
import '../../view/layout/global/on_boarding/screen/splash_screen.dart';
import '../../view/layout/global/setting/screen/help_screen.dart';
import '../../view/layout/global/setting/screen/notifications_screen.dart';
import '../../view/layout/global/setting/screen/privacy_policy_screen.dart';
import '../../view/layout/user/bottom_navigation/bottom_navigation_screen.dart';
import '../../view/layout/user/my_car/screen/add_new_car_screen.dart';
import '../../view/layout/user/my_car/screen/my_cars_screen.dart';
import '../../view/layout/user/package/screen/my_packages_screen.dart';
import '../../view/layout/user/package/screen/user_packages_details_screen.dart';
import '../../view/layout/user/payment/screen/user_choose_payment_methods_screen.dart';
import '../../view/layout/user/reservations/screen/details_screen.dart';
import '../../view/layout/user/reservations/screen/my_reservations_screen.dart';
import '../../view/layout/user/reservations/screen/previous_reservation_history_screen.dart';
import '../../view/layout/user/setting/screen/edit_user_profile_screen.dart';
import '../../view/layout/worker/bottom_navigation/worker_bottom_navigation_bar_screen.dart';
import '../../view/layout/worker/home/screen/worker_parking_history_car_screen.dart';
import '../../view/layout/worker/qr_code_scan/screen/valid_scanner_code_screen.dart';
import '../../view/layout/worker/qr_code_scan/screen/worker_add_image_screen.dart';
import '../../view/layout/worker/qr_code_scan/screen/worker_car_pictures_screen.dart';
import '../../view/layout/worker/qr_code_scan/screen/worker_qr_code_scanner_screen.dart';
import '../../view/layout/worker/requests/screen/request_setting_screen.dart';
import '../../view/layout/worker/requests/screen/worker_car_details_requests_screen.dart';
import '../../view/layout/worker/requests/screen/worker_car_entry_requests_screen.dart';
import '../../view/layout/worker/requests/screen/worker_car_receive_requests_screen.dart';
import '../../view/layout/worker/requests/screen/worker_request_new_service_screen.dart';
import '../../view/layout/worker/services/screen/worker_details_services_screen.dart';
import '../../view/layout/worker/setting/screen/edit_profile_screen.dart';

class AppRouters {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) args = settings.arguments;
    switch (settings.name) {
      case ZoomImageScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ZoomImageScreen(
            args: args,
          ),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case OnBoardingScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(
            args: args,
          ),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RegisterThroughScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegisterThroughScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(
            args: args,
          ),
        );
      case RegistrationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreen(),
        );
      case RegistrationOtpScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => RegistrationOtpScreen(
            args: args,
          ),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case ForgotPasswordOtpScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordOtpScreen(
            args: args,
          ),
        );
      case NewPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => NewPasswordScreen(
            args: args,
          ),
        );
      case UserBottomNavigationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const UserBottomNavigationScreen(),
        );
      case WorkerBottomNavigationBarScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const WorkerBottomNavigationBarScreen(),
        );
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );
      case PrivacyPolicyScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        );
      case NotificationsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );
      case UserProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const UserProfileScreen(),
        );
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordScreen(),
        );
      case MyCarsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyCarsScreen(),
        );
      case AddNewCarScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AddNewCarScreen(
            args: args,
          ),
        );
      case PreviousReservationHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PreviousReservationHistoryScreen(),
        );
      case HelpScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HelpScreen(),
        );
      case WorkerCareEntryRequestsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const WorkerCareEntryRequestsScreen(),
        );
      case WorkerCarReceiveRequestsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const WorkerCarReceiveRequestsScreen(),
        );
      case WorkerParkingHistoryCarScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const WorkerParkingHistoryCarScreen(),
        );
      case NotificationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );
      case WorkerCarDetailsRequestsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WorkerCarDetailsRequestsScreen(
            args: args,
          ),
        );
      case WorkerDetailsServicesScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WorkerDetailsServicesScreen(
            args: args,
          ),
        );
      case WorkerQrCodeScannerScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const WorkerQrCodeScannerScreen(),
        );
      case WorkerAddImageScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WorkerAddImageScreen(
            args: args,
          ),
        );
      case ChooseLangScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ChooseLangScreen(),
        );
      case MyPackagesScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyPackagesScreen(),
        );
      case MyReservations.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyReservations(),
        );
      case DetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(
            args: args,
          ),
        );
      case UserPackagesDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => UserPackagesDetailsScreen(
            args: args,
          ),
        );
      case UserChoosePaymentMethods.routeName:
        return MaterialPageRoute(
          builder: (_) => const UserChoosePaymentMethods(),
        );
      case RequestSettingScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RequestSettingScreen(),
        );
      case ValidScannerCodeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ValidScannerCodeScreen(
            args: args,
          ),
        );
      case WorkerRequestNewServiceScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WorkerRequestNewServiceScreen(
            args: args,
          ),
        );
      case WorkerCarPicturesScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WorkerCarPicturesScreen(
            args: args,
          ),
        );
      case MyReservationsQrCodeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyReservationsQrCodeScreen(
              //   args: args,
              ),
        );
      default:
        return null;
    }
  }
}
