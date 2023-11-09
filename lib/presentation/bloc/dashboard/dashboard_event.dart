part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class IndexBottomNavChange extends DashboardEvent {
  final int newIndex;
  const IndexBottomNavChange({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}

class IndexBottomNavDokterChange extends DashboardEvent {
  final int newIndex;
  const IndexBottomNavDokterChange({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}

class ResetState extends DashboardEvent {}
