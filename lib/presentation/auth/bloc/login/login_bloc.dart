import 'package:bloc/bloc.dart';
import 'package:flutter_berdagang_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_berdagang_app/data/models/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final result = await authRemoteDatasource.login(
        event.email,
        event.password,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
