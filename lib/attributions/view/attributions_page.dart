import 'package:flutter/material.dart';

class AttributionsPage extends LicensePage {
  AttributionsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AttributionsPage());
  }

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
      'assets/icon_transparent.png',
      key: const Key('application_icon_image'),
      width: 100,
    );
  }
}
