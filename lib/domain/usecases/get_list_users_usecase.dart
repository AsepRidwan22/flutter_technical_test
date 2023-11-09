import 'package:fan_technical_test/common/failure.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:dartz/dartz.dart';

class GetListUsersUsecase {
  final DataAccountRepository repository;

  GetListUsersUsecase(this.repository);

  Future<Either<Failure, List<UsersModel>>> execute() async {
    return repository.getListUsers();
  }
}
