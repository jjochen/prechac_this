import 'package:flutter/material.dart';

class AttributionsPage extends LicensePage {
  const AttributionsPage({Key? key}) : super(key: key);

  static const routeName = 'attributions';

  @override
  String? get applicationName {
    return 'PrechacThis';
  }

  @override
  String? get applicationVersion {
    return 'v1.0.0';
  }

  @override
  String? get applicationLegalese {
    return '©2021 Jochen Pfeiffer';
  }

  @override
  Widget? get applicationIcon {
    return Image.asset(
      'assets/ic_launcher.png',
      key: const Key('application_icon_image'),
      width: 96,
    );
  }
}
