import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/app/constants/app_constants.dart';
import 'package:test_project/app/widgets/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(
              blue.value,
            ),
          ),
          width: width,
          height: height * 0.065,
          child: Center(
            child: Text(
              text,
              style: appstyle(
                16,
                color ?? Colors.white,
                FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
