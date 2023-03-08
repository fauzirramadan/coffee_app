import 'package:coffe_app/core/bloc/login_cubit/login_cubit.dart';
import 'package:coffe_app/utils/theme.dart';
import 'package:coffe_app/view/widgets/custom_field.dart';
import 'package:coffe_app/view/widgets/loading_circular.dart';
import 'package:coffe_app/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _keyForm = GlobalKey();
  final TextEditingController pinC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ConfigColor.darkBrown,
        body: Form(
          key: _keyForm,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomField(
                  controller: pinC,
                  inputType: TextInputType.number,
                  hint: "Enter PIN",
                  suffixIcon: const Icon(Icons.security),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    var cubit = context.read<LoginCubit>();
                    if (state is LoginLoading) {
                      return const LoadingCircular();
                    }
                    return PrimaryButton(
                      title: "SIGN IN",
                      onPressed: () {
                        bool isValid = _keyForm.currentState!.validate();
                        if (isValid) {
                          cubit.login(pinC.text);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
