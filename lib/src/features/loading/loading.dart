import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/features/widgets/loading_status.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingStatus(),
    );
  }
}
