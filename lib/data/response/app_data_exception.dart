import 'package:firebase_auth/firebase_auth.dart';

import '../../model/app_exception.dart';

class InternetException extends AppException {
  InternetException(String? message)
      : super(
          "No Internet Exception",
          message!,
        );
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message])
      : super(
          'Request Time out',
          message,
        );
}

class FirebaseAuthExceptions extends AppException {
  final FirebaseAuthException exception;

  FirebaseAuthExceptions(this.exception) : super() {
    _setMessageAndDetails();
  }

  void _setMessageAndDetails() {
    switch (exception.code) {
      case 'email-already-in-use':
        title = 'Email Already in Use';
        message = 'Email already in use. Please use another email';
        break;
      case 'wrong-password':
        title = 'Incorrect Password';
        message = 'Password incorrect. Please check your password';
        break;
      case 'invalid-email':
        title = 'invalid-email';
        message = 'invalid-email-title';
        break;
      case 'invalid-credential':
        message =
            'Invalid email or password. Please check your credentials and try again.';
        title = 'Check Email or Password';
        break;
      case 'weak-password':
        message = 'Weak password. Please enter a stronger password.';
        title = 'Invalid Password';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later.';
        title = 'Too Many Requests';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed.';
        title = 'Operation Not Allowed';
        break;
      case 'user-disabled':
        message = 'This user has been disabled.';
        title = 'User Disabled';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        title = 'User Not Found';
        break;
      default:
        message = 'Please check your internet connection or other issues.';
        title = 'Error Occurred';
        break;
    }
  }
}

class OthersException extends AppException {
  OthersException([String? message]) : super('Other Exception', message);
}
