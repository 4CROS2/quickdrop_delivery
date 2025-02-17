import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/extensions/string_extensions.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title',
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'QuickDrop',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Questrial',
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'delivery'.capitalize(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Redhat',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
