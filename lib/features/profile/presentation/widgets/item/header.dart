import 'package:flutter/material.dart';

Widget buildProfileSection() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            'https://storage.googleapis.com/a1aa/image/ZlZz8xYKewVVZSKLqQmruw0BPEyzE4h4PjjXuHhRcotfekMnA.jpg',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'Huy Hoàng',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle, color: Color(0xFF00AAFF)),
                ],
              ),
              const Text(
                '84972266748',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Cập nhật sinh trắc học',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.edit, color: Color(0xFF00AAFF)),
      ],
    ),
  );
}