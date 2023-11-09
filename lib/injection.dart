import 'package:fan_technical_test/data/repositories/data_repository_account_impl.dart';
import 'package:fan_technical_test/data/service/service_api_account.dart';
import 'package:fan_technical_test/data/sources/account_remote_data_source.dart';
import 'package:fan_technical_test/domain/repositories/data_account_repository.dart';
import 'package:fan_technical_test/domain/usecases/email_sign_in_usecase.dart';
import 'package:fan_technical_test/domain/usecases/email_sign_out_usecase.dart';
import 'package:fan_technical_test/domain/usecases/email_sign_up_usecase.dart';
import 'package:fan_technical_test/domain/usecases/forgot_password_usecase.dart';
import 'package:fan_technical_test/domain/usecases/get_list_users_usecase.dart';
import 'package:fan_technical_test/domain/usecases/get_user_usecase.dart';
import 'package:fan_technical_test/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/login_form/login_form_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:fan_technical_test/presentation/bloc/register_form/register_form_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => ServiceApiAccount(),
  );

  // Data Source
  locator.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(
      serviceApiAccount: locator(),
    ),
  );

  // Repositry
  locator.registerLazySingleton<DataAccountRepository>(
    () => DataRepositoryAccountImpl(
      accountRemoteDataSource: locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => EmailSignInUsecase(locator()));
  locator.registerLazySingleton(() => EmailSignOutUsecase(locator()));
  locator.registerLazySingleton(() => EmailSignUpUsecase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordUsecase(locator()));
  locator.registerLazySingleton(() => GetListUsersUsecase(locator()));
  locator.registerLazySingleton(() => GetUserUsecase(locator()));

  // BloC
  locator.registerFactory(
    () => LoginFormBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => RegisterFormBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => ForgotPasswordBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => DashboardBloc(),
  );

  locator.registerFactory(
    () => ProfileBloc(
      locator(),
    ),
  );
}
