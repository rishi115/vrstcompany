import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';

import 'widgets/custom_text.dart';

class VertticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const VertticalMenuItem({Key? key, required this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
          color: menuController.isHovering(itemName)
              ?  background.withOpacity(.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName) ||
                    menuController.isActive(itemName),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  width: 3,
                  height: 72,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuController.returnIconFor(itemName),
                    ),
                    if (!menuController.isActive(itemName))
                      Flexible(
                          child: CustomText(
                            text: itemName,
                            color: menuController.isHovering(itemName)
                                ? Colors.white
                                : lightGrey,
                          ))
                    else
                      Flexible(
                          child: CustomText(
                            text: itemName,
                            color: Colors.white,
                            size: 18,
                            weight: FontWeight.bold,
                          ))
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
