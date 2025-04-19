part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

 
}
 class AuthenticationdUserChanged extends AuthEvent {
    const AuthenticationdUserChanged(this.user);

    final MyUser? user;

  
  }