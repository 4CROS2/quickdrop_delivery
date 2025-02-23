import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/extensions/string_extensions.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(
            year2023: false,
          ),
          Text(
            'loading...'.capitalize(),
            style: const TextStyle(
              fontFamily: 'RedHat',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
