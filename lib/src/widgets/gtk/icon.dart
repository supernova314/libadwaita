import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libadwaita/libadwaita.dart';

class GtkIcon extends StatelessWidget {
  const GtkIcon({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      name,
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(context.textColor, BlendMode.srcIn),
    );
  }
}
