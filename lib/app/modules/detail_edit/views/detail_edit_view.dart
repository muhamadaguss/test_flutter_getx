import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/app/widgets/app_style.dart';
import 'package:test_project/app/widgets/custom_btn.dart';
import 'package:test_project/app/widgets/custom_textfield.dart';
import 'package:test_project/app/widgets/height_spacer.dart';

import '../controllers/detail_edit_controller.dart';

class DetailEditView extends GetView<DetailEditController> {
  const DetailEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.user.id == null
            ? const Text('Add User')
            : const Text('Detail Page'),
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
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const HeightSpacer(size: 50),
                    controller.user.avatar == null
                        ? CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              "assets/icons/user.png",
                            ),
                          )
                        : CircleAvatar(
                            radius: 50.r,
                            backgroundImage: NetworkImage(
                              controller.user.avatar ?? "",
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
                            SizedBox(
                              width: 150.w,
                              child: CustomTextField(
                                controller: controller.firstNameController,
                                hintText: "First Name",
                                keyboardType: TextInputType.name,
                                // initialValue: controller.user.firstName,
                              ),
                            ),
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
                            SizedBox(
                              width: 150.w,
                              child: CustomTextField(
                                controller: controller.lastNameController,
                                hintText: "Last Name",
                                keyboardType: TextInputType.name,
                                // initialValue: controller.user.firstName,
                              ),
                            ),
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
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const HeightSpacer(size: 35),
                    CustomButton(
                      text: "Save",
                      onTap: () {
                        if (controller.user.id == null) {
                          controller.createUser();
                        } else {
                          controller.updateUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
