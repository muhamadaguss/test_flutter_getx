import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/api/remote_datasource.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/data/repositories/login_repository.dart';
import 'package:test_project/app/data/repositories_impl/login_repository_impl.dart';
import 'package:test_project/app/utils/network_info.dart';
import 'package:test_project/app/widgets/custom_toast.dart';

import '../../../../main.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late FToast fToast;
  final LoginRepository loginRepository = LoginRepositoryImpl(
    networkInfo: NetworkInfoImpl(),
    remoteDataSource: RemoteDataSource(),
  );
  final visibility = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChangeVisibility() {
    visibility.value = !visibility.value;
  }

  void login() async {
    isLoading.value = true;
    final response = await loginRepository.login(
        email: emailController.text, password: passwordController.text);

    response.fold((fail) {
      isLoading.value = false;
      return fToast.showToast(
        child: CustomToast(
          color: Colors.red,
          color2: redDark,
          title: "Error",
          message: fail.message,
          iconPath: "assets/icons/close.svg",
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    }, (r) {
      isLoading.value = false;
      final box = GetStorage();
      box.write("token", r.token);
      Get.offAllNamed('/home');
    });
  }
}
