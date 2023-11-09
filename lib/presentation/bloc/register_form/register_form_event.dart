part of 'register_form_bloc.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

class RegisterFormNameChanged extends RegisterFormEvent {
  final String name;
  const RegisterFormNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class RegisterFormEmailChanged extends RegisterFormEvent {
  final String email;
  const RegisterFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegisterFormPasswordChanged extends RegisterFormEvent {
  final String password;
  const RegisterFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RegisterFormPasswordConfChanged extends RegisterFormEvent {
  final String passwordConf;
  const RegisterFormPasswordConfChanged({required this.passwordConf});

  @override
  List<Object> get props => [passwordConf];
}

class RegisterFormObsecurePasswordChanged extends RegisterFormEvent {
  final bool obsecure;
  const RegisterFormObsecurePasswordChanged({required this.obsecure});

  @override
  List<Object> get props => [obsecure];
}

class RegisterFormObsecurePasswordConfChanged extends RegisterFormEvent {
  final bool obsecureConf;
  const RegisterFormObsecurePasswordConfChanged({required this.obsecureConf});

  @override
  List<Object> get props => [obsecureConf];
}

class OnEmailSignUp extends RegisterFormEvent {
  const OnEmailSignUp();
  @override
  List<Object> get props => [];
}
