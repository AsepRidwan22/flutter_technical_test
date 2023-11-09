import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserUsecase {
  final DataAccountRepository repository;

  GetUserUsecase(this.repository);

  Future<Either<Failure, User?>> execute() async {
    return repository.getUser();
  }
}
