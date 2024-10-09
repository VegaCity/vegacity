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

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 50,
          left: 5, // Điều chỉnh vị trí của card chồng
          child: Container(
            width: 170, // Kích thước của card chồng
            height: 170,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
        // Card chồng nằm dưới
        Container(
          margin: EdgeInsets.only(bottom: 20), // Khoảng cách giữa các item
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LabelText(
                    content: package.name,
                    size: AssetsConstants.defaultFontSize - 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                  // Icon(Icons.chevron_right, size: 16, color: Colors.black),
                ],
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 10),

              // Thông tin lô hàng
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hình ảnh
                  Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'https://storage.googleapis.com/a1aa/image/gb34ouB3ZX4FLtgdghjBezLlISIiiAXyoYwwbmqLZ482bPyJA.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // Khoảng cách giữa hình ảnh và chi tiết lô hàng
                  // Chi tiết lô hàng
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LabelText(
                        content: package.description,
                        size: AssetsConstants.defaultFontSize - 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      LabelText(
                        content:
                            'Price: ${package.price.toString()}', // Giá lô hàng
                        size: AssetsConstants.defaultFontSize - 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // Card chồng nằm trên
      ],
    );

    // Container(
    //   padding: const EdgeInsets.all(AssetsConstants.defaultPadding - 12.0),
    //   margin: const EdgeInsets.only(bottom: AssetsConstants.defaultMargin),
    //   decoration: BoxDecoration(
    //     color: AssetsConstants.whiteColor,
    //     border: Border.all(color: AssetsConstants.subtitleColor),
    //     borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
    //   ),
    //   child: Column(
    //     children: [
    //       InkWell(
    //         onTap: () {
    //           // Điều hướng đến màn hình chi tiết nếu cần
    //           // context.router.push(TestDetailScreenRoute(testId: test.id));
    //         },
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       LabelText(
    //                         content: package.name,
    //                         size: AssetsConstants.defaultFontSize - 12.0,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                       LabelText(
    //                         content: package.description,
    //                         size: AssetsConstants.defaultFontSize - 14.0,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                       LabelText(
    //                         content: package.price.toString(),
    //                         size: AssetsConstants.defaultFontSize - 14.0,
    //                         fontWeight: FontWeight.w600,
    //                       ),

    //                     ],
    //                   ),
    //                 ),
    //                 // CustomLabelStatus(
    //                 //   width: size.width * 0.22,
    //                 //   height: size.height * 0.035,
    //                 //   content: test.status, // Giả sử có trường status
    //                 //   size: AssetsConstants.defaultFontSize - 18.0,
    //                 //   backgroundColor: Colors.blue, // Màu mặc định
    //                 //   contentColor: Colors.white,
    //                 // ),
    //               ],
    //             ),
    //             SizedBox(height: size.height * 0.01),
    //             Container(
    //               width: size.width * 1,
    //               height: 1,
    //               color: AssetsConstants.subtitleColor,
    //             ),
    //             SizedBox(height: size.height * 0.01),
    //             // Thêm các thông tin chi tiết khác của test item ở đây
    //           ],
    //         ),
    //       ),
    //       // Thêm các nút hoặc hành động khác nếu cần
    //       CustomButton(
    //         isOutline: true,
    //         size: AssetsConstants.defaultFontSize - 14.0,
    //         content: 'Chi tiết'.toUpperCase(),
    //         onCallback: onCallback,
    //         isActive: true,
    //         width: size.width * 1,
    //         height: size.height * 0.04,
    //         backgroundColor: AssetsConstants.whiteColor,
    //         contentColor: AssetsConstants.blue2,
    //       ),
    //       SizedBox(height: size.height * 0.005),
    //     ],
    //   ),
    // );
  }
}
