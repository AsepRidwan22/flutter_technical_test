import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/common/regex_validation_field.dart';
import 'package:fan_technical_test/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fan_technical_test/presentation/component/custom_simple_button.dart';
import 'package:fan_technical_test/presentation/component/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: const Text('Lupa Password'),
        ),
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listenWhen: (previous, context) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );

              debugPrint('field register berhasil');
            }
          },
          child: const ForgotPasswordFields(),
        ));
  }
}

class ForgotPasswordFields extends StatelessWidget {
  const ForgotPasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, forgotPassword) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                labelText: 'Email',
                initialValue: forgotPassword.email,
                //ctrl + klik untuk melihat kode validateEmail
                //kode tersebut dimaksudkan untuk menjawab pertanyaan pertama bagian email
                validator: validateEmail,
                onChanged: (text) {
                  context
                      .read<ForgotPasswordBloc>()
                      .add(ForgotPasswordEmailChanged(email: text));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomSimpleButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(const OnForgotPasswordSubmit());
                  }
                },
                child: (forgotPassword.isLoading == true)
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Forgot Password'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
