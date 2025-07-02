import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/responsiveness.dart';
import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
        children: [
          Container(
            color: Colors.black,

          )
        ],
      )
          : IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            key.currentState?.openDrawer();
          }),
      title: Row(
        children: [
          Visibility(
              visible: !ResponsiveWidget.isSmallScreen(context),
              child: const CustomText(
                text: "DashBoard",
                color: lightGrey,
                size: 22,
                weight: FontWeight.bold,
              )),
          // Container(
          //   decoration: BoxDecoration(
          //       color: active.withOpacity(.5),
          //       borderRadius: BorderRadius.circular(30)),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: Colors.white, borderRadius: BorderRadius.circular(30)),
          //     padding: const EdgeInsets.all(2),
          //     margin: const EdgeInsets.all(2),
          //     child: const CircleAvatar(
          //       backgroundColor: light,
          //       child: Icon(
          //         Icons.person_outline,
          //         color: light,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      iconTheme: const IconThemeData(color: light),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      toolbarHeight: 80,
    );
