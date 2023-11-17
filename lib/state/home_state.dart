abstract class UserEvent {}

class FetchUserData extends UserEvent {}

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final dynamic userData;

  UserLoaded({required this.userData});
}

class UserLoadFailure extends UserState {}
