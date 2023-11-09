import 'package:dartz/dartz.dart';
import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DataAccountRepository {
  Future<Either<Failure, List<UsersModel>>> getListUsers();
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, String>> emailSignUp(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, String>> emailSignIn(
    String email,
    String password,
  );
  Future<Either<Failure, String>> forgotPassword(
    String email,
  );
  Future<Either<Failure, String>> emailSignOut();
}
