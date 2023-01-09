import 'package:flutter/material.dart';
import 'package:package_localization/package_localizations.dart';

class PackageLocalizationDemo extends StatefulWidget {
  const PackageLocalizationDemo({Key? key}) : super(key: key);

  @override
  State<PackageLocalizationDemo> createState() =>
      _PackageLocalizationDemoState();
}

class _PackageLocalizationDemoState extends State<PackageLocalizationDemo> {
  @override
  Widget build(BuildContext context) {
    var localization = PackageLocalizations.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Text(localization.email),
          Text(localization.password),
          Text(localization.cancel),
          Text(localization.ok),
          Text(localization.clear),
        ],
      ),
    );
  }
}
