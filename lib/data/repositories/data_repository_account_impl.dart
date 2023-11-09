import 'package:dartz/dartz.dart';
import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:fan_technical_test/data/sources/account_remote_data_source.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DataRepositoryAccountImpl implements DataAccountRepository {
  AccountRemoteDataSource accountRemoteDataSource;
  DataRepositoryAccountImpl({required this.accountRemoteDataSource});

  @override
  Future<Either<Failure, String>> emailSignIn(
    String email,
    String password,
  ) async {
    try {
      final result = await accountRemoteDataSource.emailSignIn(email, password);
      debugPrint('result dari repositories data: $result');
      return Right(result);
    } on FirebaseException catch (e) {
      debugPrint('kesalahan di repository: $e');
      final errorMessage = e.message.toString().replaceAll(
          'An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]',
          'Sign In Failed');
      return Left(FirebaseFailure(errorMessage));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> emailSignOut() async {
    try {
      final result = await accountRemoteDataSource.emailSignOut();
      return Right(result);
    } on FirebaseException catch (e) {
      debugPrint('kesalahan di repository: $e');
      return const Left(FirebaseFailure('Sign Out Failed'));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> emailSignUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result =
          await accountRemoteDataSource.emailSignUp(name, email, password);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> getListUsers() async {
    try {
      final result = await accountRemoteDataSource.getListUsers();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.stackTrace.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final result = await accountRemoteDataSource.getUser();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.stackTrace.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      final result = await accountRemoteDataSource.forgotPassword(email);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.stackTrace.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
