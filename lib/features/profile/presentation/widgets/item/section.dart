import 'package:flutter/material.dart';

Widget buildSection({required String title, required List<Widget> children}) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 14.0, right: 14.0, top: 8.0, bottom: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...children,
      ],
    ),
  );
}
