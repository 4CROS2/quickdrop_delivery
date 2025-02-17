import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/core/extensions/string_extensions.dart';
import 'package:quickdrop_delivery/src/core/functions/custom_snack_bar.dart';
import 'package:quickdrop_delivery/src/core/functions/validators.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/presentation/login/cubit/login_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/login/widgets/auth_btn.dart';
import 'package:quickdrop_delivery/src/presentation/login/widgets/divider.dart';
import 'package:quickdrop_delivery/src/presentation/login/widgets/inputs.dart';
import 'package:quickdrop_delivery/src/presentation/login/widgets/other_login_btn.dart';
import 'package:quickdrop_delivery/src/presentation/login/widgets/title.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final ScrollController _scrollController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  late AppLocalizations _localizations;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginError) {
            showCustomSnackbar(
              context,
              message:
                  BlocProvider.of<LoginCubit>(context).localizationResponse(
                code: state.message,
                localizations: _localizations,
              ),
            );
          }
        },
        builder: (BuildContext context, LoginState state) {
          return Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  stops: const <double>[.54, 1],
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Constants.primaryColor,
                    Colors.white,
                  ],
                ),
              ),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: _scrollController,
                    physics: Constants.bouncingScrollPhysics,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    children: <Widget>[
                      AuthTitle(),
                      Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: AuthInput(
                          controller: _emailController,
                          validator: emailvalidator,
                          isEnabled: state is! LoginLoading,
                          label: AppLocalizations.of(context)!
                              .emailLabel
                              .capitalize(),
                        ),
                      ),
                      AuthInput(
                        isEnabled: state is! LoginLoading,
                        controller: _passwordController,
                        label: AppLocalizations.of(context)!
                            .passwordLabel
                            .capitalize(),
                        isObscure: true,
                        validator: passwordValidator,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _localizations.passwordRecovery.capitalize(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: AuthBtn(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                          disabled: state is LoginLoading,
                          label: AppLocalizations.of(context)!.loginButton,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: AuthDivider(),
                      ),
                      OtherLoginBtn(
                        onTap: () {
                          context.read<LoginCubit>().loginWithGoogle();
                        },
                        svgImage: 'assets/images/svg/google.svg',
                        label: 'google',
                      ),
                      if (Platform.isIOS)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: OtherLoginBtn(
                            onTap: () {},
                            svgImage: 'assets/images/svg/apple.svg',
                            label: 'apple',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
