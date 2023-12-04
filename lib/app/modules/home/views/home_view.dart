import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/widgets/app_style.dart';
import 'package:test_project/app/widgets/height_spacer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.DETAIL_EDIT, arguments: {
                  "user": User(),
                });
              },
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          color: Colors.white,
          opacity: .6,
          progressIndicator: Center(
            child: Lottie.asset('assets/lottie/loading.json'),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.refreshController,
              header: const WaterDropHeader(),
              footer: CustomFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("release to load more");
                  } else {
                    body = const Text("No more Data");
                  }
                  return SizedBox(
                    height: 55.h,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: () {
                controller.onRefresh();
              },
              onLoading: () {
                controller.onLoading();
              },
              child: ListView.separated(
                itemCount: controller.users.length,
                separatorBuilder: (context, index) =>
                    const HeightSpacer(size: 10),
                itemBuilder: (context, index) {
                  final item = controller.users[index];
                  return ListTile(
                    title: Text(
                      item.firstName != null && item.lastName != null
                          ? "${item.firstName} ${item.lastName}"
                          : item.firstName ?? item.lastName ?? "",
                      style: appstyle(
                        14,
                        Colors.black,
                        FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      item.email ?? "",
                      style: appstyle(
                        12,
                        lightGrey,
                        FontWeight.w400,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(
                        item.avatar ?? "",
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          title: "Warning",
                          desc: "Are you sure you want to delete this user?",
                          btnCancelOnPress: () {
                            Get.back();
                          },
                          btnOkOnPress: () {
                            controller.deleteUser(item.id!);
                          },
                        ).show();
                      },
                    ),
                    onTap: () {
                      Get.toNamed(Routes.DETAIL, arguments: {
                        "userId": item.id,
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
