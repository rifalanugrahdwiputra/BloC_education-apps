import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutButtonPressed extends LogoutEvent {
  final BuildContext context;
  const LogoutButtonPressed({required this.context});

  @override
  List<Object> get props => [context];
}
