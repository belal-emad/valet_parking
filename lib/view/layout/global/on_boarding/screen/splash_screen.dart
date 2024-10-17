import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/hive/hive_methods.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../user/bottom_navigation/bottom_navigation_screen.dart';
import '../../../worker/bottom_navigation/worker_bottom_navigation_bar_screen.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/register_through_screen.dart';
import 'choose_lang_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.authScaffoldColor(context),
      child: Scaffold(
        backgroundColor: AppColor.authScaffoldColor(context),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: const AssetImage(AppImages.appImage),
                  width: context.width(),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<AuthController>(
              builder: (context, authController, _) {
                return ApiResponseWidget(
                  apiResponse: authController.profileResponse,
                  onReload: _getData,
                  isEmpty: false,
                  unauthorizedWidget: const SizedBox(),
                  axis: Axis.horizontal,
                  child: const SizedBox(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _initial() {
    if (HiveMethods.isFirstTime()) {
      Future.delayed(const Duration(seconds: 2), () {
        NavigatorMethods.pushNamedAndRemoveUntil(
          context,
          ChooseLangScreen.routeName,
        );
      });
    } else {
      _checkLogin();
    }
  }

  void _checkLogin() {
    if (HiveMethods.getToken() != null) {
      context.read<AuthController>().initialProfile();
      Future.microtask(() {
        setState(() {
          token = HiveMethods.getToken();
        });
        _getData();
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        NavigatorMethods.pushNamedAndRemoveUntil(
          context,
          RegisterThroughScreen.routeName,
        );
      });
    }
  }

  void _getData() {
    context.read<AuthController>().getProfile(
      onSuccess: () {
        Future.delayed(const Duration(seconds: 1), () {
          if (context.read<AuthController>().profileModel?.accountType ==
              'user') {
            NavigatorMethods.pushNamedAndRemoveUntil(
              context,
              UserBottomNavigationScreen.routeName,
            );
          } else {
            NavigatorMethods.pushNamedAndRemoveUntil(
              context,
              WorkerBottomNavigationBarScreen.routeName,
            );
          }
        });
      },
      onUnauthorized: () {
        Future.delayed(const Duration(seconds: 1), () {
          NavigatorMethods.pushNamedAndRemoveUntil(
            context,
            RegisterThroughScreen.routeName,
          );
        });
      },
    );
  }
}
