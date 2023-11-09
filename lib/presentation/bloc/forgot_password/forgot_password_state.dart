part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final String message;
  final FormStatusEnum formStatus;
  final bool isLoading;

  const ForgotPasswordState({
    required this.email,
    required this.message,
    required this.formStatus,
    required this.isLoading,
  });

  ForgotPasswordState copyWith({
    String? email,
    String? message,
    FormStatusEnum? formStatus,
    bool? isLoading,
  }) {
    return ForgotPasswordState(
        email: email ?? this.email,
        message: message ?? this.message,
        formStatus: formStatus ?? this.formStatus,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [
        email,
        message,
        formStatus,
        isLoading,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  static String emailInit = '';
  static String messageInit = '';
  static FormStatusEnum formStatusInit = FormStatusEnum.initForm;
  static bool isLoadingInit = false;

  ForgotPasswordInitial()
      : super(
          email: emailInit,
          message: messageInit,
          formStatus: formStatusInit,
          isLoading: isLoadingInit,
        );
}
