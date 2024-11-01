import 'package:auto_route/auto_route.dart';
import 'package:base/features/e-tag/domain/entities/card_entities.dart';
import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:base/features/test/domain/entities/house_entities.dart';
import '../../../../../configs/routes/app_router.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';

class CardItem extends HookConsumerWidget {
  const CardItem({
    super.key,
    required this.card,
    required this.onCallback,
  });

  final CardEntities card;
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              backgroundColor: Colors.white,
              contentPadding: const EdgeInsets.all(16.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image for the package
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      card.imageUrl.isNotEmpty
                          ? card.imageUrl
                          : 'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
                      height: 120,
                      width: size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Package Name
                  Text(
                    card.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    card.etagCode,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Package Description
                  Text(
                    card.cccdPassport,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  // Package Price
                  Text(
                    card.birthday
                        .toIso8601String()
                        .substring(0, 10), // Chỉ lấy phần ngày
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Close Button
                  ElevatedButton(
                    onPressed: () {
                      context.router.push(const TransferScreenRoute());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Nạp tiền',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Center(
        child: Container(
          width: 350, // Same width as HTML card
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white, // Card background color
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Section
              Center(
                child: Image.network(
                  card.imageUrl.isNotEmpty
                      ? card.imageUrl
                      : 'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10), // Space between icon and details

              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        card.fullName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      card.birthday.toIso8601String().substring(0, 10),
                      style: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Price Section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A5A5A), // Price background color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
