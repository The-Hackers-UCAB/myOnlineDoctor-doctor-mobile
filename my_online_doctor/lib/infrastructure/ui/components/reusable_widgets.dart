import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'image_view_component.dart';

Widget progressIndicator() =>
    const Center(child: CircularProgressIndicator(color: colorPrimary));

Widget renderImageView(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 40),
    height: MediaQuery.of(context).size.width * (40 / 100),
    width: double.infinity,
    child: const ImageViewComponent('assets/icon/doctor_logo.png'));


Widget heightSeparator(BuildContext context, double heightPercentage) => SizedBox(
      height: MediaQuery.of(context).size.height * heightPercentage,
    );
  