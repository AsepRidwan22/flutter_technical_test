import 'package:fan_technical_test/data/service/service_api_account.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteDataSource {
  Future<List<UsersModel>> getListUsers();
  Future<User?> getUser();
  Future<String> emailSignUp(String name, String email, String password);
  Future<String> emailSignIn(String email, String password);
  Future<String> forgotPassword(String email);
  Future<String> emailSignOut();
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ServiceApiAccount serviceApiAccount;

  AccountRemoteDataSourceImpl({required this.serviceApiAccount});

  @override
  Future<String> emailSignIn(String email, String password) async {
    return await serviceApiAccount.emailSignIn(email, password);
  }

  @override
  Future<String> emailSignOut() async {
    return await serviceApiAccount.emailSignOut();
  }

  @override
  Future<String> emailSignUp(String name, String email, String password) async {
    return await serviceApiAccount.emailSignUp(name, email, password);
  }

  @override
  Future<List<UsersModel>> getListUsers() async {
    return await serviceApiAccount.getListUsers();
  }

  @override
  Future<User?> getUser() async {
    return await serviceApiAccount.getUser();
  }

  @override
  Future<String> forgotPassword(String email) async {
    return await serviceApiAccount.forgotPassword(email);
  }
}
