import 'package:flutter/cupertino.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:vrsstranslinkcompany/routing/router.dart';
import 'package:vrsstranslinkcompany/routing/routes.dart';

Navigator companyLocalNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: companyGenerateRoute,
      initialRoute: homePageRoute,
    );
