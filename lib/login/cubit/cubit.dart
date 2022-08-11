import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_project/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isNotShown = true;

  void changeIcon() {
    isNotShown = !isNotShown;
    emit(ChangeIconState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.uid);
      print(value.user?.email);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(LoginErrorState(error.toString()));
    });
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:udemy_flutter/modules/social_app/social_login/cubit/states.dart';
//
// class LoginCubit extends Cubit<LoginStates> {
//   LoginCubit() : super(LoginInitialState());
//
//   static LoginCubit get(context) => BlocProvider.of(context);
//
//   void userLogin({
//     @required String email,
//     @required String password,
//   }) {
//     emit(LoginLoadingState());
//
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         )
//         .then((value) {
//           print(value.user.email);
//           print(value.user.uid);
//           emit(LoginSuccessState(value.user.uid));
//     })
//         .catchError((error)
//     {
//       emit(LoginErrorState(error.toString()));
//     });
//   }
//
//   IconData suffix = Icons.visibility_outlined;
//   bool isPassword = true;
//
//   void changePasswordVisibility() {
//     isPassword = !isPassword;
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//
//     emit(ChangePasswordVisibilityState());
//   }
// }
