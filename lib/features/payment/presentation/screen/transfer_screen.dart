import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class ContactScreen extends HookConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Transfer Screen'),
        ),
      ),
    );
  }
}