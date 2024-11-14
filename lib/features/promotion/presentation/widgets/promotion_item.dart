import 'package:animate_do/animate_do.dart';
import 'package:base/features/promotion/domain/entities/promotion_entities.dart';
import 'package:base/features/promotion/presentation/widgets/promotion_details.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PromotionItem extends HookConsumerWidget {
  const PromotionItem({
    super.key,
    required this.promotion,
    required this.onCallback,
  });

  final PromotionEntities promotion;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromotionDetails(promotion: promotion),
          ),
        );
      },
      child: FadeInUp(
        child: Container(
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
                  'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
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
                    minHeight: 40,
                  ),
                  child: Text(
                    promotion.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Package Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50,
                  ),
                  child: Text(
                    promotion.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
