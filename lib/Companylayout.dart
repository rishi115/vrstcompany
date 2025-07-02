import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/widgets/side_menu.dart';
import 'constants/responsiveness.dart';
import 'controllers/local_navigator.dart';
import 'widgets/top_nav.dart';


class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child:CompanySideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                  child:
                  CompanySideMenu()
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: companyLocalNavigator(),
                ),
              )
            ],
          ),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: companyLocalNavigator(),
      )
      ),
    );
  }
}
