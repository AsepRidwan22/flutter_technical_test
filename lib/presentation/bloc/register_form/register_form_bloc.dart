import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:fan_technical_test/domain/usecases/email_sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final EmailSignUpUsecase emailSignUp;

  RegisterFormBloc(
    this.emailSignUp,
  ) : super(RegisterFormInitial()) {
    on<RegisterFormNameChanged>((event, emit) {
      final newName = event.name;

      emit(state.copyWith(
        name: newName,
      ));
    });

    on<RegisterFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<RegisterFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<RegisterFormObsecurePasswordChanged>((event, emit) {
      final newObsecure = event.obsecure;

      emit(state.copyWith(
        obsecurePassword: newObsecure,
      ));
    });

    on<RegisterFormPasswordConfChanged>((event, emit) {
      final newPassword = event.passwordConf;

      emit(state.copyWith(
        passwordConf: newPassword,
      ));
    });

    on<RegisterFormObsecurePasswordConfChanged>((event, emit) {
      final newObsecure = event.obsecureConf;

      emit(state.copyWith(
        obsecurePasswordConf: newObsecure,
      ));
    });

    on<OnEmailSignUp>((event, emit) async {
      debugPrint('onEmailSignUp Jalan');
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
        isLoading: true,
      ));

      final result =
          await emailSignUp.execute(state.name, state.email, state.password);

      result.fold(
        (failure) {
          emit(state.copyWith(
            formStatus: FormStatusEnum.failedSubmission,
            message: failure.message,
            isLoading: false,
          ));
        },
        (data) {
          emit(state.copyWith(
            formStatus: FormStatusEnum.successSubmission,
            message: data,
            isLoading: false,
          ));
        },
      );
    });
  }
}
