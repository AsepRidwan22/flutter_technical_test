import 'package:equatable/equatable.dart';
import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/domain/usecases/email_sign_in_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final EmailSignInUsecase emailSignInUsecase;

  LoginFormBloc(
    this.emailSignInUsecase,
  ) : super(LoginFormInitial()) {
    on<LoginFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<LoginFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<LoginFormObsecurePasswordChanged>((event, emit) {
      final newObsecure = event.obsecure;

      emit(state.copyWith(
        obsecurePassword: newObsecure,
      ));
    });

    on<OnEmailSignIn>((event, emit) async {
      emit(state.copyWith(
          formStatus: FormStatusEnum.submittingForm, isLoading: true));

      final result = await emailSignInUsecase.execute(
        state.email,
        state.password,
      );

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

          debugPrint('Login Berhasil');
        },
      );
    });
  }
}
