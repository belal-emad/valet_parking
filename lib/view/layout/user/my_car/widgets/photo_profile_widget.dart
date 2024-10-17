import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/images/image_methods.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_file_image.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_network_image.dart';

class PhotoProfileWidget extends StatefulWidget {
  final void Function(File) onSuccess;
  final File? image;
  const PhotoProfileWidget({
    super.key,
    required this.onSuccess,
    required this.image,
  });

  @override
  State<PhotoProfileWidget> createState() => _PhotoProfileWidgetState();
}

class _PhotoProfileWidgetState extends State<PhotoProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImageMethods.pickImageBottomSheet(
          context,
          onSuccess: (v) {
            widget.onSuccess.call(v);
            Navigator.pop(context);
          },
        );
      },
      child: Container(
        width: 115,
        height: 110,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: widget.image != null
                  ? CustomFileImage(
                      fit: BoxFit.cover,
                      imageFile: widget.image,
                    )
                  : const CustomNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: Urls.testNoonLogo,
                    ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.darkTextColor(context).withOpacity(0.3),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.camera_alt_rounded,
                color: AppColor.whiteColor(context).withOpacity(0.6),
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
