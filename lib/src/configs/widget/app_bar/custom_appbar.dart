import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../text/paragraph.dart';

class CustomerAppBar extends StatelessWidget {
  const CustomerAppBar(
      {super.key,
      this.title,
      this.icon,
      this.widget,
      this.onTap,
      this.rightIcon,
      this.gestureDetector,
      this.style,
      this.color});
  final String? title;
  final String? icon;
  final Widget? widget;
  final VoidCallback? onTap;
  final IconButton? rightIcon;
  final GestureDetector? gestureDetector;
  final TextStyle? style;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back, size: 28, 
              color: color
            )
          ),
        ),
        Expanded(
          flex: 12,
          child: Paragraph(
            content: title ?? '',
            textAlign: TextAlign.center,
            style: style ?? STYLE_LARGE.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(child: widget ?? const SizedBox()),
      ],
    );
  }
}
