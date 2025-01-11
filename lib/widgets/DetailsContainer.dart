import 'package:flutter/cupertino.dart';
import 'package:vrsstranslinkcompany/constants/responsiveness.dart';

import '../constants/style.dart';
import 'custom_text.dart';


DetailsContainer({
  required String title,
  required String value,
  required BuildContext context,
  bool? isMobileScreen=false,
}){
  var W = MediaQuery.of(context).size.width;
  var H = MediaQuery.of(context).size.height;
  //706
  return Container(
    height: isMobileScreen!?20:H*0.104,
    decoration: BoxDecoration(
      color: light,
      borderRadius: BorderRadius.circular(8),
    ),
    child:  Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:  isMobileScreen?20:H*0.015,
            ),
            ResponsiveWidget.isSmallScreen(context)?
            Expanded(
              child: Container(
                width: 200,
                child: CustomText(
                  text: title,
                  size: 15,
                  color: dark,
                  weight: FontWeight.normal,
                ),
              ),
            ):CustomText(
              text: title,
              size: 15,
              color: dark,
              weight: FontWeight.normal,
            ),
            SizedBox(
              height:  isMobileScreen?7:H*0.015,
            ),
            Expanded(
              child: CustomText(
                text: value,
                size: 20,
                color: dark,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    ),
  );
}