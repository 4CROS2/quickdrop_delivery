part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

final class HomeInitial extends HomeState {}
