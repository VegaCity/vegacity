// import 'package:flutter/material.dart';

// class CarouselIndicator extends StatelessWidget {
//   final int currentPage;
//   final List<String> imgList;

//   const CarouselIndicator({
//     Key? key,
//     // required this.currentPage,
//     required this.imgList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         for (int i = 0; i < imgList.length; i++)
//           Container(
//             width: i == currentPage ? 7 : 5,
//             height: i == currentPage ? 7 : 5,
//             margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: i == currentPage
//                   ? const Color.fromARGB(255, 30, 144, 255)
//                   : Colors.grey,
//             ),
//           ),
//       ],
//     );
//   }
// }
