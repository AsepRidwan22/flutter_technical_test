import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUsecase {
  final DataAccountRepository repository;

  ForgotPasswordUsecase(this.repository);

  Future<Either<Failure, String>> execute(
    String email,
  ) async {
    return repository.forgotPassword(email);
  }
}
