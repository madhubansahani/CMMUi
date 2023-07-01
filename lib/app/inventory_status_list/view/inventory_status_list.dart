import 'package:cmms/app/inventory_status_list/view/inventory_status_list_mobile.dart';
import 'package:cmms/app/inventory_status_list/view/inventory_status_list_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/home_controller.dart';
import '../../home/widgets/header_widget.dart';
import '../../home/widgets/home_drawer.dart';
import '../../theme/dimens.dart';
import '../../utils/responsive.dart';
import '../inventory_status_list_controller.dart';

class InventoryStatusListScreen extends GetView<InventoryStatusListController> {
  InventoryStatusListScreen({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AppBar(
              title: HeaderWidget(),
              elevation: 0,
              toolbarHeight: 90,
              automaticallyImplyLeading: false,
            )
          : AppBar(
              title: Text('Inventory Type List'),
              centerTitle: true,
              elevation: 0,
            ),
      body: Container(
          width: Get.width,
          height: Get.height,
          child: Row(
            children: [
              (Responsive.isMobile(context) || Responsive.isTablet(context))
                  ? Dimens.box0
                  : HomeDrawer(),
              Expanded(
                child: Column(
                  children: [
                    if (Responsive.isMobile(context) ||
                        Responsive.isTablet(context))
                      Expanded(
                        child: InventoryStatusListContentMobile(),
                      ),
                    if (Responsive.isDesktop(context))
                      Expanded(
                        child: InventoryStatusListContentWeb(),
                      )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}