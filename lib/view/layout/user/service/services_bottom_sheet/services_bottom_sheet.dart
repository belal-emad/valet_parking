import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';
import '../../home/controller/user_services_controller.dart';
import '../widgets/user_services_widget.dart';

class ServicesUserBottomSheet extends StatefulWidget {
  const ServicesUserBottomSheet({super.key});

  @override
  State<ServicesUserBottomSheet> createState() =>
      _ServicesUserBottomSheetState();
}

class _ServicesUserBottomSheetState extends State<ServicesUserBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserServiceController>(context, listen: false)
          .initialServices();
      Provider.of<UserServiceController>(context, listen: false).getServices();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServiceController>(
        builder: (context, servicesController, _) {
      return ApiResponseWidget(
        apiResponse: servicesController.servicesResponse,
        isEmpty: servicesController.services.isEmpty,
        onReload: () => servicesController.getServices(),
        child: UserBottomSheet(
          children: [
            ...List.generate(
              servicesController.services.length,
              (index) => UserServicesWidget(
                userServicesModel: servicesController.services[index],
              ),
            ),
          ],
        ),
      );
    });
  }
}
