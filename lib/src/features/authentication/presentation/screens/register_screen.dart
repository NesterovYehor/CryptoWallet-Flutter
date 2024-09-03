import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc_event.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:crypto_track/src/widgets/app_input_field.dart';
import 'package:crypto_track/src/widgets/app_btn.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController username = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              LogoWidget(width: MediaQuery.of(context).size.width * 0.35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.loc.register,
                    style: AppFont.bold.s25,
                  )
                ],
              ),
              const Spacer(),
              AppInputField(
                controller: username,
                hint: context.loc.enterYourUsername,
                title: context.loc.username,
                obscureText: false,
                icon: Icons.person,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppInputField(
                controller: email,
                hint: context.loc.enterYourEmail,
                title: context.loc.email,
                obscureText: false,
                icon: Icons.email,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppInputField(
                controller: password,
                hint: context.loc.enterYourPassword,
                title: context.loc.password,
                obscureText: true,
                icon: Icons.lock,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppBtn(
                        label: context.loc.register,
                        onTap: () => context.read<AuthBloc>().add(AuthRegisterEvent(
                            username.text, email.text, password.text))),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Text(
                        context.loc.alreadyHaveAccount,
                        style: const TextStyle(color: AppColor.blueClr),
                      ),
                      onTap: () => context.go(AppRoute.login.path))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }
}
