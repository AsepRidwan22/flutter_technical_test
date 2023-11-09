part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  final String name;
  final bool isLoading;
  final String email;
  final String password;
  final String passwordConf;
  final String message;
  final bool obsecurePassword;
  final bool obsecurePasswordConf;
  final FormStatusEnum formStatus;
  final UsersModel? usersModel;

  const RegisterFormState({
    required this.name,
    required this.isLoading,
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.message,
    required this.obsecurePassword,
    required this.obsecurePasswordConf,
    required this.formStatus,
    this.usersModel,
  });

  RegisterFormState copyWith({
    String? name,
    bool? isVerification,
    bool? isLoading,
    String? email,
    String? password,
    String? passwordConf,
    String? message,
    bool? obsecurePassword,
    bool? obsecurePasswordConf,
    UsersModel? usersModel,
    FormStatusEnum? formStatus,
  }) {
    return RegisterFormState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConf: passwordConf ?? this.passwordConf,
      message: message ?? this.message,
      formStatus: formStatus ?? this.formStatus,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
      obsecurePasswordConf: obsecurePasswordConf ?? this.obsecurePasswordConf,
      usersModel: usersModel,
    );
  }

  @override
  List<Object?> get props => [
        name,
        isLoading,
        email,
        password,
        passwordConf,
        message,
        formStatus,
        obsecurePasswordConf,
        obsecurePassword,
        usersModel,
      ];
}

class RegisterFormInitial extends RegisterFormState {
  static String nameInit = '';
  static bool isVerificationInit = false;
  static bool isLoadingInit = false;
  static String emailInit = '';
  static String passwordInit = '';
  static String passwordConfInit = '';
  static String messageInit = '';
  static bool obsecurePasswordInit = true;
  static bool obsecurePasswordConfInit = true;
  static FormStatusEnum formStatusInit = FormStatusEnum.initForm;

  RegisterFormInitial()
      : super(
          name: nameInit,
          isLoading: isLoadingInit,
          email: emailInit,
          password: passwordInit,
          passwordConf: passwordConfInit,
          message: messageInit,
          obsecurePassword: obsecurePasswordInit,
          obsecurePasswordConf: obsecurePasswordConfInit,
          formStatus: formStatusInit,
          usersModel: null,
        );
}
