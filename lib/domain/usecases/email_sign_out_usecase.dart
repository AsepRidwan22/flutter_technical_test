import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';

class EmailSignOutUsecase {
  final DataAccountRepository repository;

  EmailSignOutUsecase(this.repository);

  Future<Either<Failure, String>> execute() async {
    return repository.emailSignOut();
  }
}
