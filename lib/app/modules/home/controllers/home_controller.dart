import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/widgets/custom_toast.dart';

import '../../../../main.dart';
import '../../../api/remote_datasource.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories_impl/user_repository_impl.dart';
import '../../../utils/network_info.dart';

class HomeController extends GetxController {
  final UserRepository userRepository = UserRepositoryImpl(
    networkInfo: NetworkInfoImpl(),
    remoteDataSource: RemoteDataSource(),
  );
  final isLoading = false.obs;
  late FToast fToast;
  List<User> users = <User>[].obs;
  int page = 0;
  late RefreshController refreshController;
  @override
  void onInit() {
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    refreshController = RefreshController();
    getUsers();
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

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void onRefresh() {
    users.clear();
    getUsers();
    refreshController.refreshCompleted();
  }

  void onLoading() {
    getUsers(loadmore: true);
    refreshController.loadComplete();
  }

  void getUsers({bool loadmore = false}) async {
    isLoading.value = true;
    List<User> usersLoaded = [];
    page = loadmore ? page + 1 : 1;
    if (loadmore) {
      usersLoaded.addAll(users);
    }
    final result = await userRepository.getUsers(page);
    result.fold((fail) {
      isLoading.value = false;
      fToast.showToast(
          child: CustomToast(
        color: Colors.red,
        color2: redDark,
        title: "Error",
        message: fail.message,
        iconPath: "assets/icons/close.svg",
      ));
    }, (r) {
      isLoading.value = false;
      if (loadmore) {
        usersLoaded.addAll(r);
        users = usersLoaded;
        update();
      } else {
        users.addAll(r);
      }
    });
  }

  void deleteUser(int id) async {
    isLoading.value = true;
    final result = await userRepository.deleteUser(id);

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
            message: "Delete User Success",
            iconPath: "assets/icons/check.svg",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
        users.clear();
        getUsers();
      },
    );
  }
}
