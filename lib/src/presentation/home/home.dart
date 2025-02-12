import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/active_switch/active_switch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          ActiveSwitch(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello word 🦈🤩'),
            TextButton(
              onPressed: () {
                sl<AuthUseCase>().logOut();
              },
              child: Text('close sesion'),
            ),
          ],
        ),
      ),
    );
  }
}
