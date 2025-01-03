import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDetails extends StatelessWidget {
  final PackageEntities package;

  const HomeDetails({super.key, required this.package});
  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    package.name,
                    style: const TextStyle(
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
                    package.name,
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
                        'Time: ${package.crDate?.toLocal().toString().split(' ')[0]} - ${package.upsDate?.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProgramRules(
                    package: package,
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
          package.imageUrl.isNotEmpty
              ? package.imageUrl
              : 'https://storage.googleapis.com/a1aa/image/jCeQ5BWBaYW2VqCp9dQ2q4YIfbPdqTZqCfHtEMnxxj2C6yKnA.jpg',
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
  final PackageEntities package;

  const ProgramRules({super.key, required this.package});

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
          package.description,
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
          package.price.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
