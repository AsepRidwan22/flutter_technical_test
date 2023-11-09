import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';

class EmailSignUpUsecase {
  final DataAccountRepository repository;

  EmailSignUpUsecase(this.repository);

  Future<Either<Failure, String>> execute(
    String name,
    String email,
    String password,
  ) async {
    return repository.emailSignUp(name, email, password);
  }
}
