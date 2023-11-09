import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/common/regex_validation_field.dart';
import 'package:fan_technical_test/presentation/bloc/register_form/register_form_bloc.dart';
import 'package:fan_technical_test/presentation/component/custom_simple_button.dart';
import 'package:fan_technical_test/presentation/component/custom_text_form_field.dart';
import 'package:fan_technical_test/presentation/component/password_text_form_field.dart';
import 'package:fan_technical_test/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Register'),
      ),
      body: BlocListener<RegisterFormBloc, RegisterFormState>(
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
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            debugPrint('field register gagal');
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
                builder: (context) => const LoginScreen(),
              ));
            });
            debugPrint('field register berhasil');
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
      child: BlocBuilder<RegisterFormBloc, RegisterFormState>(
        builder: (context, registerForm) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  labelText: 'Name',
                  initialValue: registerForm.name,
                  validator: validateName,
                  onChanged: (text) {
                    context
                        .read<RegisterFormBloc>()
                        .add(RegisterFormNameChanged(name: text));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  initialValue: registerForm.email,
                  //ctrl + klik untuk melihat kode validateEmail
                  //kode tersebut dimaksudkan untuk menjawab pertanyaan pertama bagian email
                  validator: validateEmail,
                  onChanged: (text) {
                    context
                        .read<RegisterFormBloc>()
                        .add(RegisterFormEmailChanged(email: text));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomPasswordTextFormField(
                  initialValue: registerForm.password,
                  sufflixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                    child: GestureDetector(
                      onTap: (() => context.read<RegisterFormBloc>().add(
                            RegisterFormObsecurePasswordChanged(
                              obsecure: !registerForm.obsecurePassword,
                            ),
                          )),
                      child: SvgPicture.asset(
                        (registerForm.obsecurePassword)
                            ? "assets/eyeSlash.svg"
                            : "assets/eye-slash.svg",
                      ),
                    ),
                  ),
                  //ctrl + klik untuk melihat kode validatePassword
                  //validator dimaksudkan untuk menjawab pertanyaan pertama bagian password
                  validator: validatePassword,
                  obscureText: registerForm.obsecurePassword,
                  onChanged: (text) => context
                      .read<RegisterFormBloc>()
                      .add(RegisterFormPasswordChanged(password: text)),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomPasswordTextFormField(
                  initialValue: registerForm.passwordConf,
                  sufflixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                    child: GestureDetector(
                      onTap: (() => context.read<RegisterFormBloc>().add(
                            RegisterFormObsecurePasswordConfChanged(
                              obsecureConf: !registerForm.obsecurePasswordConf,
                            ),
                          )),
                      child: SvgPicture.asset(
                        (registerForm.obsecurePasswordConf)
                            ? "assets/eyeSlash.svg"
                            : "assets/eye-slash.svg",
                      ),
                    ),
                  ),
                  //ctrl + klik untuk melihat kode validatePassword
                  //validator dimaksudkan untuk menjawab pertanyaan pertama bagian password
                  validator: (item) => item!.isEmpty
                      ? 'Password cannot be empty'
                      : registerForm.password == registerForm.passwordConf
                          ? 'Password must be identical to the one above'
                          : null,
                  obscureText: registerForm.obsecurePasswordConf,
                  onChanged: (text) => context
                      .read<RegisterFormBloc>()
                      .add(RegisterFormPasswordChanged(password: text)),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomSimpleButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      context
                          .read<RegisterFormBloc>()
                          .add(const OnEmailSignUp());
                    }
                  },
                  child: (registerForm.isLoading == true)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        )
                      : const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
