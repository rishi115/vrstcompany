import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/constants/responsiveness.dart';
import 'package:vrsstranslinkcompany/routing/routes.dart';
import 'package:vrsstranslinkcompany/widgets/custom_text.dart';
import 'package:vrsstranslinkcompany/widgets/side_menu_item.dart';
import 'package:get/get.dart';

import '../helpers/SharedPreference/shared_preferences_methods.dart';

class CompanySideMenu extends StatelessWidget {
  const CompanySideMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
            color: light,
            child: Column(
              children: [
                Divider(color: lightGrey.withOpacity(.1), ),
                SizedBox(
                  height: 110.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: companySideMenuItemRoutes
                          .map((item) => SideMenuItem(
                              itemName: item.name,
                              onTap: () {
                                if(item.route == authenticationPageRoute){
                                  removeAllFromCache();
                                  menuController.changeActiveItemTo(homePageDisplayName);
                                }
                                if (!menuController.isActive(item.name)) {
                                  menuController.changeActiveItemTo(item.name);
                                  if(ResponsiveWidget.isSmallScreen(context)) {
                                    Get.back();
                                  }
                                  navigationController.navigateTo(item.route);
                                }
                              }))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

