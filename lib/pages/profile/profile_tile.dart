import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? trailing;
  final Function() onTap;
  final bool isLogout;
  final bool forChat;

  const ProfileTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isLogout = false,
    this.trailing,
    this.forChat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                forChat
                    ? Image.asset(
                        'assets/graphics/whatsapp-grey.png',
                        height: 14.sp,
                        color: theme.indicatorColor.withOpacity(0.5),
                      )
                    : Icon(icon,
                        color: isLogout
                            ? Colors.redAccent
                            : theme.indicatorColor.withOpacity(0.5),
                        size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  title,
                  style: isLogout
                      ? theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.redAccent)
                      : theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            isLogout
                ? Container()
                : Row(
                    children: [
                      trailing != null
                          ? Text(trailing!, style: theme.textTheme.bodySmall)
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
