import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/choose_enter_new_car_or_deliver_car_bottom_sheet.dart';
import '../../../custom_widgets/bottom_navigation/worker_bottom_navigation_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../home/screen/worker_home_screen.dart';
import '../requests/screen/requests_worker_screen.dart';
import '../services/screen/services_worker_screen.dart';
import '../setting/screen/setting_worker_screen.dart';

class WorkerBottomNavigationBarScreen extends StatefulWidget {
  static const String routeName = 'WorkerBottomNavigationBarScreen';
  const WorkerBottomNavigationBarScreen({super.key});

  @override
  State<WorkerBottomNavigationBarScreen> createState() =>
      _WorkerBottomNavigationBarScreenState();
}

class _WorkerBottomNavigationBarScreenState
    extends State<WorkerBottomNavigationBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: [
          const WorkerHomeScreen(),
          const RequestsWorkerScreen(),
          const ServicesWorkerScreen(),
          SettingWorkerScreen(
            onLangChanged: () {
              setState(() {});
            },
          ),
        ][_currentIndex],
        bottomNavigationBar: WorkerBottomNavigationBar(
          onChanged: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          onMedTap: () {
            NavigatorMethods.showAppBottomSheet(
              context,
              enableDrag: true,
              isScrollControlled: true,
              const ChooseEnterAnewCarOrDeliverCarBottomSheet(),
            );
          },
        ),
      ),
    );
  }
}
