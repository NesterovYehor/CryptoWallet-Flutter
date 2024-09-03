import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc_event.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:crypto_track/src/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/src/widgets/app_input_field.dart';
import 'package:crypto_track/src/widgets/app_btn.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    context.loc.logIn,
                    style: AppFont.bold.s25,
                  )
                ],
              ),
              const Spacer(),
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
             Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    context.loc.forgotPassword,
                    style: AppFont.normal.s14.copyWith(color: AppColor.blueClr),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppBtn(
                      label: context.loc.logIn,
                      onTap: () => context
                          .read<AuthBloc>()
                          .add(AuthLogInEvent(email.text, password.text)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Text(
                        context.loc.dontHaveAccount,
                        style: AppFont.normal.s17.copyWith(color: AppColor.blueClr),
                      ),
                      onTap: () => context.go(AppRoute.register.path))
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
