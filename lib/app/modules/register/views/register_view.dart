import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/widgets/app_style.dart';
import 'package:test_project/app/widgets/custom_btn.dart';
import 'package:test_project/app/widgets/custom_textfield.dart';
import 'package:test_project/app/widgets/height_spacer.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              horizontal: 29.w,
              vertical: 30.h,
            ),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  SvgPicture.asset(
                    'assets/svg/logo_login.svg',
                  ),
                  const HeightSpacer(size: 36),
                  Text(
                    "Register Details",
                    style: appstyle(24, Colors.black, FontWeight.w500),
                  ),
                  const HeightSpacer(size: 18),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const HeightSpacer(size: 10),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.visibility.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.onChangeVisibility();
                          },
                          icon: Icon(
                            controller.visibility.value == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      )),
                  const HeightSpacer(size: 60),
                  CustomButton(
                    text: "Register",
                    onTap: () {
                      controller.register();
                    },
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account?",
                        style: appstyle(
                          13,
                          Color(lightGrey.value),
                          FontWeight.w400,
                        ),
                        children: [
                          const WidgetSpan(
                            child: SizedBox(width: 5),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Get.offNamed(Routes.LOGIN);
                              },
                              child: Text(
                                "Login",
                                style: appstyle(
                                  13,
                                  Colors.black,
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
