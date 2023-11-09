import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/common/regex_validation_field.dart';
import 'package:fan_technical_test/presentation/bloc/login_form/login_form_bloc.dart';
import 'package:fan_technical_test/presentation/component/custom_simple_button.dart';
import 'package:fan_technical_test/presentation/component/custom_text_form_field.dart';
import 'package:fan_technical_test/presentation/component/password_text_form_field.dart';
import 'package:fan_technical_test/presentation/screens/dashboard_screen.dart';
import 'package:fan_technical_test/presentation/screens/forgot_password_screen.dart';
import 'package:fan_technical_test/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Login'),
      ),
      body: BlocListener<LoginFormBloc, LoginFormState>(
        listenWhen: (previous, current) {
          if (previous.formStatus == FormStatusEnum.submittingForm) {
            debugPrint('field belum diisi');
            return true;
          } else {
            debugPrint('field sudah diisi');
            return false;
          }
        },
        listener: (context, state) {
          if (state.formStatus == FormStatusEnum.failedSubmission) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(state.message), // Menampilkan pesan kesalahan jika ada
                backgroundColor:
                    Colors.red, // Atur warna latar belakang untuk pesan gagal
              ),
            );
            debugPrint('field login gagal');
          } else if (state.formStatus == FormStatusEnum.successSubmission) {
            Future(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }).then((value) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ));
            });
            debugPrint('field login berhasil');
          }
        },
        child: const LoginFormFields(),
      ),
    );
  }
}

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LoginFormBloc, LoginFormState>(
        builder: (context, loginForm) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  initialValue: loginForm.email,
                  labelText: 'Email',
                  validator: validateEmail,
                  onChanged: (text) {
                    context
                        .read<LoginFormBloc>()
                        .add(LoginFormEmailChanged(email: text));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomPasswordTextFormField(
                  initialValue: loginForm.password,
                  sufflixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                    child: GestureDetector(
                      onTap: (() => context.read<LoginFormBloc>().add(
                            LoginFormObsecurePasswordChanged(
                              obsecure: !loginForm.obsecurePassword,
                            ),
                          )),
                      child: SvgPicture.asset(
                        (loginForm.obsecurePassword)
                            ? "assets/eyeSlash.svg"
                            : "assets/eye-slash.svg",
                      ),
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  obscureText: loginForm.obsecurePassword,
                  onChanged: (text) => context
                      .read<LoginFormBloc>()
                      .add(LoginFormPasswordChanged(password: text)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text('Lupa Password?'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomSimpleButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      // Form valid, lakukan tindakan seperti login
                      context.read<LoginFormBloc>().add(const OnEmailSignIn());
                    }
                  },
                  child: (loginForm.isLoading == true)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        )
                      : const Text('Login'),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomSimpleButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Daftar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
