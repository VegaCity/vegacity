import 'package:auto_route/auto_route.dart';
import 'package:base/features/history/domain/entities/history_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../configs/routes/app_router.dart';
import '../../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../../utils/constants/asset_constant.dart';

class OrderItem extends HookConsumerWidget {
  const OrderItem({
    Key? key,
    required this.history,
    required this.onCallback,
  }) : super(key: key);

  final HistoryEntity history;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AssetsConstants.subtitleColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage(history.imageUrl ?? ''),
            // ),
            const SizedBox(width: 10),
            // Thông tin giao dịch
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    history.type,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    history.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    (history.crDate?.toString()) ?? 'Ngày không rõ',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Chi tiết số tiền và trạng thái
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${history.amount}VND',
                  style: TextStyle(
                    fontSize: 14,
                    // color: history.isPositive ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  history.status ?? 'Chưa xác định',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 5),
                // Text(
                //   history.method ?? 'Phương thức không rõ',
                //   style: const TextStyle(
                //     fontSize: 12,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
