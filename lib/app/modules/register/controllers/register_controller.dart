import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/widgets/custom_toast.dart';

import '../../../../main.dart';
import '../../../api/remote_datasource.dart';
import '../../../data/repositories/register_repository.dart';
import '../../../data/repositories_impl/register_repository_impl.dart';
import '../../../utils/network_info.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late FToast fToast;
  final formKey = GlobalKey<FormState>();
  final RegisterRepository registerRepository = RegisterRepositoryImpl(
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

  void register() async {
    isLoading.value = true;
    final response = await registerRepository.register(
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
