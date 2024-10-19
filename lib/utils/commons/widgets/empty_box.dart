import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/asset_constant.dart';
import 'widgets_common_export.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize - 8.0,
            color: Colors.black,
            // fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
