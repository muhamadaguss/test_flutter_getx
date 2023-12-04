import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/routes/app_pages.dart';

import '../../../../main.dart';
import '../../../api/remote_datasource.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/update_user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories_impl/user_repository_impl.dart';
import '../../../utils/network_info.dart';
import '../../../widgets/custom_toast.dart';

class DetailEditController extends GetxController {
  User user = Get.arguments["user"] ?? User();
  final isLoading = false.obs;
  late FToast fToast;
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final UserRepository userRepository = UserRepositoryImpl(
    networkInfo: NetworkInfoImpl(),
    remoteDataSource: RemoteDataSource(),
  );

  @override
  void onInit() {
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    setUser();
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

  void setUser() {
    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    emailController.text = user.email ?? "";
  }

  void updateUser() async {
    isLoading.value = true;
    final result = await userRepository.updateUser(
        user.id ?? 0,
        UpdateUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
        ));

    result.fold(
      (l) {
        isLoading.value = false;
        fToast.showToast(
          child: CustomToast(
            color: Colors.red,
            color2: redDark,
            title: "Error",
            message: l.message,
            iconPath: "assets/icons/close.svg",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      },
      (r) {
        isLoading.value = false;
        fToast.showToast(
          child: const CustomToast(
            color: green,
            color2: greenDark,
            title: "Success",
            message: "Update Success",
            iconPath: "assets/icons/check.svg",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  void createUser() async {
    isLoading.value = true;
    final result = await userRepository.createUser(User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
    ));

    result.fold(
      (l) {
        isLoading.value = false;
        fToast.showToast(
          child: CustomToast(
            color: Colors.red,
            color2: redDark,
            title: "Error",
            message: l.message,
            iconPath: "assets/icons/close.svg",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      },
      (r) {
        isLoading.value = false;
        fToast.showToast(
          child: const CustomToast(
            color: green,
            color2: greenDark,
            title: "Success",
            message: "Create User Success",
            iconPath: "assets/icons/check.svg",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
        Get.offAllNamed(Routes.HOME);
      },
    );
  }
}
