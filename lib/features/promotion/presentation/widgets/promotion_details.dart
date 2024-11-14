import 'package:base/features/payment/presentation/screen/transfer_screen.dart';
import 'package:base/features/promotion/domain/entities/promotion_entities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromotionDetails extends StatelessWidget {
  final PromotionEntities promotion;

  const PromotionDetails({super.key, required this.promotion});

  Future<void> _saveToSharedPreferences(String promotionCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('promotionCode', promotionCode);
  }

  @override
  Widget build(BuildContext context) {
    _saveToSharedPreferences(promotion.promotionCode);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0052CC),
                  Color(0xFF00AAFF),
                  Color.fromARGB(255, 111, 194, 208),
                  Color.fromARGB(255, 116, 240, 231),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'Voucher',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promotion.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0048BA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.calendarAlt, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Time: ${promotion.startDate.toLocal().toString().split(' ')[0]} - ${promotion.endDate.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProgramRules(
                    promotion: promotion,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
          width: MediaQuery.of(context).size.width,
          height: 300,
          fit: BoxFit.cover,
        ),
        // const Positioned(
        //   top: 100,
        //   left: 20,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text(
        //         'Mời bạn mới dùng Zalopay',
        //         style: TextStyle(
        //           fontSize: 24,
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       const SizedBox(height: 5),
        //       const Text(
        //         'Nhận Xu không giới hạn',
        //         style: TextStyle(fontSize: 18, color: Colors.white),
        //       ),
        //       const SizedBox(height: 10),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class ProgramRules extends StatelessWidget {
  final PromotionEntities promotion;

  const ProgramRules({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF0048BA),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          promotion.description,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Price',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF0048BA),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          promotion.requireAmount.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Code',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF0048BA),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          promotion.promotionCode,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransferScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0048BA),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
            child: const Text(
              'Áp dụng',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
