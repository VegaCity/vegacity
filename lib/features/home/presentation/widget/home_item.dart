import 'package:auto_route/auto_route.dart';
import 'package:base/features/home/presentation/widget/home_details.dart';
import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../configs/routes/app_router.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';
import 'dart:async';

class HomeItem extends HookConsumerWidget {
  const HomeItem({
    super.key,
    required this.package,
    required this.onCallback,
  });

  final PackageEntities package;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final opacity = useState(1.0); // Trạng thái cho hiệu ứng nhấp nháy

    // Sử dụng hiệu ứng nhấp nháy
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        opacity.value = opacity.value == 1.0 ? 0.0 : 1.0;
      });
      return timer.cancel;
    }, []);

    return Stack(
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
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

              // Title text
              Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                child: Text(
                  package.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDetails(package: package),
                      ),
                    );
                  },
                  child: const Text(
                    "Xem thêm",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // "New" label in the top right corner
        Positioned(
          top: 10,
          right: 10,
          child: AnimatedOpacity(
            opacity: opacity.value,
            duration: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
