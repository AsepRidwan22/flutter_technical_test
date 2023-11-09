import 'package:fan_technical_test/common/request_state_enum.dart';
import 'package:fan_technical_test/domain/usecases/get_user_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUsecase getUserUsecase;

  ProfileBloc(
    this.getUserUsecase,
  ) : super(ProfileInitial()) {
    on<FetchCurrentUser>((event, emit) async {
      debugPrint('fetch data user jalan di bloc');
      emit(state.copyWith(requestStateEnum: RequestStateEnum.loading));

      final result = await getUserUsecase.execute();

      result.fold(
        (failure) async {
          emit(state.copyWith(
            message: failure.message,
            requestStateEnum: RequestStateEnum.error,
          ));
        },
        (data) async {
          emit(state.copyWith(
            user: data!.email.toString(),
            requestStateEnum: RequestStateEnum.loaded,
          ));
        },
      );
    });
  }
}
