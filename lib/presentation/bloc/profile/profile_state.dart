part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String user;
  final String message;
  final RequestStateEnum requestStateEnum;

  const ProfileState({
    required this.user,
    required this.message,
    required this.requestStateEnum,
  });

  ProfileState copyWith({
    String? user,
    String? message,
    RequestStateEnum? requestStateEnum,
  }) {
    return ProfileState(
      user: user ?? this.user,
      message: message ?? this.message,
      requestStateEnum: requestStateEnum ?? this.requestStateEnum,
    );
  }

  @override
  List<Object> get props => [user, message, requestStateEnum];
}

class ProfileInitial extends ProfileState {
  static String userInit = '';
  static String messageInit = '';
  static RequestStateEnum requestStateEnumInit = RequestStateEnum.initial;

  ProfileInitial()
      : super(
          user: userInit,
          message: messageInit,
          requestStateEnum: requestStateEnumInit,
        );
}
