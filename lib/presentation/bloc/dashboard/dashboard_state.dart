part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final int indexBottomNav;
  final int indexBottomNavDokter;

  final FormStatusEnum formStatus;

  const DashboardState({
    required this.indexBottomNav,
    required this.indexBottomNavDokter,
    required this.formStatus,
  });

  DashboardState copyWith({
    int? indexBottomNav,
    int? indexBottomNavDokter,
    FormStatusEnum? formStatus,
  }) {
    return DashboardState(
      indexBottomNav: indexBottomNav ?? this.indexBottomNav,
      indexBottomNavDokter: indexBottomNavDokter ?? this.indexBottomNavDokter,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [indexBottomNav, indexBottomNavDokter, formStatus];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial()
      : super(
          indexBottomNav: 0,
          indexBottomNavDokter: 0,
          formStatus: FormStatusEnum.initForm,
        );
}
