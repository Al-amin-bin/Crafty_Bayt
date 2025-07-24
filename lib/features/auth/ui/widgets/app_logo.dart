import 'package:crafty_bay/app/asset_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key, this.width, this.height,
  });
  final double? width;
  final double?  height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetPath.appLogoPath, width: width?? 120, height: height,);
  }
}