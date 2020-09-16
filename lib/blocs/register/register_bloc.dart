import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:grocery_app/blocs/register/bloc.dart';
import 'package:grocery_app/blocs/simple_bloc_delegate.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/repo/user_repo.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.initial());

  // SimpleBlocDelegate delegate = SimpleBlocDelegate();

  // @override
  // // TODO: implement initialState
  // RegisterState get initialState => RegisterState.initial();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged &&
          event is! RegisterPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged ||
          event is RegisterPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          event.email, event.password, event.img8);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
      String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      String email, String password, Uint8List img8) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
        img8: img8,
      );
      yield RegisterState.success();
    } catch (_) {
      // delegate.onError(this, _, StackTrace.current);
      yield RegisterState.failure();
    }
  }
}
