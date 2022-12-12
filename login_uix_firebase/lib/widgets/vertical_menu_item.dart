import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/controllers.dart';
import '../constant/style.dart';
import 'custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const VerticalMenuItem({Key? key, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName!)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName!)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName!) ||
                      menuController.isActive(itemName!),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 3,
                    height: 72,
                    color: dark,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: menuController.returnIconFor(itemName!),
                      ),
                      (!menuController.isActive(itemName!))
                          ? Flexible(
                              child: CustomText(
                              text: itemName!,
                              color: menuController.isHovering(itemName!)
                                  ? dark
                                  : lightGrey,
                            ))
                          : Flexible(
                              child: CustomText(
                                text: itemName!,
                                color: dark,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
