import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';

class EmailSignInUsecase {
  final DataAccountRepository repository;

  EmailSignInUsecase(this.repository);

  Future<Either<Failure, String>> execute(
    String email,
    String password,
  ) async {
    return repository.emailSignIn(email, password);
  }
}
