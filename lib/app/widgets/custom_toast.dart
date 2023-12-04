import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/app/widgets/app_style.dart';
import 'package:test_project/app/widgets/width_spacer.dart';

class CustomToast extends StatelessWidget {
  final Color color;
  final String? title;
  final String? message;
  final Color color2;
  final String? iconPath;
  const CustomToast({
    super.key,
    required this.color,
    this.title,
    this.message,
    required this.color2,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          height: 77.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: color,
          ),
          child: Row(
            children: [
              const WidthSpacer(width: 60),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: appstyle(
                        18,
                        Colors.white,
                        FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      message ?? "",
                      style: appstyle(
                        12,
                        Colors.white,
                        FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
            ),
            child: SvgPicture.asset(
              "assets/icons/bubbles.svg",
              height: 48.h,
              width: 40.w,
              color: color2,
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/fail.svg",
                color: color2,
                height: 40.h,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  iconPath ?? "assets/icons/close.svg",
                  color: Colors.white,
                  height: 16.h,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
