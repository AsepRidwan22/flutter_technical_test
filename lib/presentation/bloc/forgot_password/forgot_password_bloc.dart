import 'package:equatable/equatable.dart';
import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:fan_technical_test/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordBloc(
    this.forgotPasswordUsecase,
  ) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<OnForgotPasswordSubmit>((event, emit) async {
      emit(state.copyWith(
          formStatus: FormStatusEnum.submittingForm, isLoading: true));

      final result = await forgotPasswordUsecase.execute(
        state.email,
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
