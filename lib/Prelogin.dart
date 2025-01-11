import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/routing/routes.dart';
import 'package:vrsstranslinkcompany/PreloginCache.dart';
import 'package:get/get.dart';

class PreLogin extends StatefulWidget {
  const PreLogin({Key? key}) : super(key: key);

  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  void initState() {
    super.initState();
    redirectToInitialRoute();
  }

  void redirectToInitialRoute() async {
    String? initialRoute = await initializeSettings();
    switch (initialRoute) {
      case CompanyrootRoute:
        Get.offAllNamed(CompanyrootRoute);
        break;
      default:
        Get.offAllNamed(authenticationPageRoute);
        break;
    }
  }

  Future<String?> initializeSettings() async {
    try {
      return await PreLoginCacheService().getPreLoginDataFromCache();
    } catch (e) {
      print('Error initializing settings: $e');
      return null; // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
