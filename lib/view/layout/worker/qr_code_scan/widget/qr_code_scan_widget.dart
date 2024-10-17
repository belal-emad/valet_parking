import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';

class QrCodeScanWidget extends StatefulWidget {
  final void Function(QRViewController) onQRViewCreated;
  const QrCodeScanWidget({super.key, required this.onQRViewCreated});

  @override
  State<QrCodeScanWidget> createState() => _QrCodeScanWidgetState();
}

class _QrCodeScanWidgetState extends State<QrCodeScanWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: widget.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColor.mainAppColor(context),
          borderRadius: 5,
          borderLength: 20,
          borderWidth: 7,
          cutOutSize: MediaQuery.of(context).size.height * 0.35),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
