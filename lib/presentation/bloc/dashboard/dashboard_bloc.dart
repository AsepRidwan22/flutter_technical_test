import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fan_technical_test/common/form_status_enum.dart';
import 'package:flutter/material.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<IndexBottomNavChange>((event, emit) async {
      final newValueBottomNav = event.newIndex;

      emit(state.copyWith(
        indexBottomNav: newValueBottomNav,
      ));
      debugPrint('indexBottomNav: $newValueBottomNav');
    });

    on<IndexBottomNavDokterChange>((event, emit) async {
      final newValueBottomNavDokter = event.newIndex;

      emit(state.copyWith(
        indexBottomNavDokter: newValueBottomNavDokter,
      ));
      debugPrint('indexBottomNav: $newValueBottomNavDokter');
    });

    on<ResetState>((event, emit) {
      debugPrint('reset state dashboard berhasil dilaksanakan');
      emit(const DashboardInitial());
    });
  }
}
