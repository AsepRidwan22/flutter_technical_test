part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final String email;
  final String password;
  final String message;
  final bool obsecurePassword;
  final FormStatusEnum formStatus;
  final bool isLoading;

  const LoginFormState({
    required this.email,
    required this.password,
    required this.message,
    required this.obsecurePassword,
    required this.formStatus,
    required this.isLoading,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    String? message,
    bool? obsecurePassword,
    FormStatusEnum? formStatus,
    bool? isLoading,
  }) {
    return LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message,
        formStatus: formStatus ?? this.formStatus,
        obsecurePassword: obsecurePassword ?? this.obsecurePassword,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [
        email,
        password,
        message,
        formStatus,
        obsecurePassword,
        isLoading,
      ];
}

class LoginFormInitial extends LoginFormState {
  static String emailInit = '';
  static String passwordInit = '';
  static String messageInit = '';
  static bool obsecurePasswordInit = true;
  static FormStatusEnum formStatusInit = FormStatusEnum.initForm;
  static bool isLoadingInit = false;

  LoginFormInitial()
      : super(
          email: emailInit,
          password: passwordInit,
          message: messageInit,
          obsecurePassword: obsecurePasswordInit,
          formStatus: formStatusInit,
          isLoading: isLoadingInit,
        );
}
