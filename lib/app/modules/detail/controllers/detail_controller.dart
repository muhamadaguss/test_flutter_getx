import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:test_project/app/api/remote_datasource.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/data/repositories/user_repository.dart';
import 'package:test_project/app/data/repositories_impl/user_repository_impl.dart';
import 'package:test_project/app/utils/network_info.dart';

import '../../../../main.dart';
import '../../../widgets/custom_toast.dart';

class DetailController extends GetxController {
  int userId = Get.arguments["userId"] ?? 0;
  final userLoaded = User().obs;
  final isLoading = false.obs;
  late FToast fToast;
  final UserRepository userRepository = UserRepositoryImpl(
    networkInfo: NetworkInfoImpl(),
    remoteDataSource: RemoteDataSource(),
  );

  @override
  void onInit() {
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    getUser();
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

  void getUser() async {
    isLoading.value = true;

    final result = await userRepository.getUser(userId);

    result.fold((l) {
      isLoading.value = false;
      return fToast.showToast(
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
    }, (r) {
      isLoading.value = false;
      userLoaded.value = r;
    });
  }
}
