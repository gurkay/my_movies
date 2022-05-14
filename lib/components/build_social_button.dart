import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants_color.dart';
import '../models/argument.dart';

class BuildSocialButton extends StatelessWidget {
  IconData icon;
  Function() onClicked;
  Color? color;
  Argument? argument;
  BuildSocialButton({
    Key? key,
    required this.icon,
    required this.onClicked,
    this.color,
    this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 60,
        height: 60,
        child: Center(
          child: FaIcon(
            icon,
            color: color,
            size: 40,
          ),
        ),
      ),
      onTap: onClicked,
    );
  }
}
