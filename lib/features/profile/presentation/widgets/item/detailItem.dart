import 'package:base/features/history/domain/entities/history_entity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class DetailItem extends HookConsumerWidget {
  DetailItem({
    super.key,
    required this.history,
    required this.onCallback,
  });

  final HistoryEntity history;
  final VoidCallback onCallback;
  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Chi tiết giao dịch
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    child: Text(
                      history.crDate.toString() ?? 'Thời gian không rõ',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  FadeInLeft(
                    child: Text(
                      history.description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 8.0, bottom: 8.0, left: 8.0),
              child: Column(
                children: [
                  // FadeInDown(
                  //   child: Icon(
                  //     history.status == 'Cancel'
                  //         ? Icons.arrow_downward
                  //         : Icons.arrow_upward,
                  //     color: history.status == 'Cancel'
                  //         ? Colors.red
                  //         : Colors.green,
                  //     size: 20,
                  //   ),
                  // ),
                  const SizedBox(height: 4),
                  FadeInUp(
                    child: Text(
                      '${formatter.format(history.amount)} VND',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: history.status == 'Pending'
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
