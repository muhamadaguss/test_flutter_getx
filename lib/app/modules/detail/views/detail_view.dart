import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/widgets/app_style.dart';
import 'package:test_project/app/widgets/custom_btn.dart';

import '../../../widgets/height_spacer.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
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
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Center(
              child: Column(
                children: [
                  const HeightSpacer(size: 50),
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: controller.userLoaded.value.avatar == null
                        ? null
                        : NetworkImage(
                            controller.userLoaded.value.avatar ?? "",
                          ),
                    backgroundColor: Colors.transparent,
                  ),
                  const HeightSpacer(size: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Name",
                            style: appstyle(
                              16,
                              Colors.black,
                              FontWeight.w500,
                            ),
                          ),
                          const HeightSpacer(size: 6),
                          Text(
                            controller.userLoaded.value.firstName ?? "",
                            style: appstyle(
                              14,
                              Colors.black,
                              FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Name",
                            style: appstyle(
                              16,
                              Colors.black,
                              FontWeight.w500,
                            ),
                          ),
                          const HeightSpacer(size: 6),
                          Text(
                            controller.userLoaded.value.lastName ?? "",
                            style: appstyle(
                              14,
                              Colors.black,
                              FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const HeightSpacer(size: 25),
                  Text(
                    "Email",
                    style: appstyle(
                      16,
                      Colors.black,
                      FontWeight.w500,
                    ),
                  ),
                  const HeightSpacer(size: 6),
                  Text(
                    controller.userLoaded.value.email ?? "",
                    style: appstyle(
                      14,
                      Colors.black,
                      FontWeight.w400,
                    ),
                  ),
                  const HeightSpacer(size: 35),
                  CustomButton(
                    text: "Update",
                    onTap: () {
                      Get.toNamed(
                        Routes.DETAIL_EDIT,
                        arguments: {"user": controller.userLoaded.value},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
