import 'package:auto_route/auto_route.dart';
import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:base/features/test/domain/entities/house_entities.dart';
import '../../../../../configs/routes/app_router.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';

// gpt nhá generate UI =))
class PackageItem extends HookConsumerWidget {
  const PackageItem({
    Key? key,
    required this.package,
    required this.onCallback,
  }) : super(key: key);

  final PackageEntities package;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo tròn ít hơn
                ),
                title: Text(package.name),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.description,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    // Thêm các thông tin khác của package tại đây
                    Text(package.price.toString()),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  package.imageUrl.isNotEmpty
                      ? package.imageUrl
                      : 'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Package Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 40, // Đảm bảo chiều cao tối thiểu là 40
                  ),
                  child: Text(
                    package.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Giới hạn tối đa 2 dòng
                    overflow: TextOverflow.ellipsis, // Dùng ... nếu vượt quá
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Package Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50, // Đảm bảo chiều cao tối thiểu là 50
                  ),
                  child: Text(
                    package.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 3, // Giới hạn tối đa 3 dòng
                    overflow: TextOverflow.ellipsis, // Dùng ... nếu vượt quá
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
