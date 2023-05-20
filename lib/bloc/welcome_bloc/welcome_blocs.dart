import 'package:disoveroman2/bloc/welcome_bloc/welcome_event.dart';
import 'package:disoveroman2/bloc/welcome_bloc/welcome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvents, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    print("welcome bloc");
    on<WelcomeEvents>((event, emit) {
      emit(WelcomeState(page: state.page));
    });
  }
}
