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
            height: 60,
            color: Colors.black,
            margin:  EdgeInsets.all(10.w),
            child: Image.asset(
              "assets/VR Safetrips final logo.png",
              fit: BoxFit.cover,
            ),
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
          Expanded(child: Container()),
          IconButton(
              icon: const Icon(
                Icons.settings,
                color: dark,
              ),
              onPressed: () {}),
          Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  ),
                  onPressed: () {}),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: light, width: 2)),
                ),
              )
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),
          ResponsiveWidget.isSmallScreen(context)?Container():
          const CustomText(
            text: "Shambhavi Tours & Travels",
            color: lightGrey,
          ),
          const SizedBox(
            width: 16,
          ),
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
