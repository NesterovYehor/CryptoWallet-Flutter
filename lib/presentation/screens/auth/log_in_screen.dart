import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/presentation/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_text_btn.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

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
                  Text("LogIn", style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),)
                ],
              ),
              const Spacer(),
              AppInputField(controller: _email, hint: "Enter your email", title: 'Email', obscureText: false, icon: Icons.email,),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              AppInputField(controller: _password, hint: "Enter Your Password", title: 'Password', obscureText: true, icon: Icons.lock,),
              const Spacer(),
              AppTextBtn(
                color: Theme.of(context).colorScheme.primary, 
                lable: "LogIn", 
                onTap: () => context.read<AuthenticationBloc>().add(AuthEventLogIn(_email.text, _password.text)),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forgot password ?", style: TextStyle(color: blueclr),)
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Text("Don't have an account ? SignUp", style: TextStyle(color: blueclr),),
                    onTap: () => context.go("/signUp")
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,)
            ],
          ),
        ),
      ),
    );
  }
}
