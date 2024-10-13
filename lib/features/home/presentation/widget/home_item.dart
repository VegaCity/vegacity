import 'package:auto_route/auto_route.dart';
import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../configs/routes/app_router.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';

// gpt nhá generate UI =))
class HomeItem extends HookConsumerWidget {
  const HomeItem({
    Key? key,
    required this.package,
    required this.onCallback,
  }) : super(key: key);

  final PackageEntities package;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top of the card
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Title text
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
            child: Text(
              package.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontFamily: 'Inter',
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          // Subtitle text
          // Padding(
          //   padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
          //   child: Text(
          //     package.description,
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Colors.grey[600],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
