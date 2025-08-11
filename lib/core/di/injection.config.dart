// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repositories_impl/category_repository_impl.dart' as _i383;
import '../../data/repositories_impl/payment_method_repository_impl.dart'
    as _i879;
import '../../data/repositories_impl/transaction_repository_impl.dart' as _i468;
import '../../domain/repositories/category_repository.dart' as _i485;
import '../../domain/repositories/payment_method_repository.dart' as _i290;
import '../../domain/repositories/transaction_repository.dart' as _i302;
import '../../domain/usecases/transaction_usecases.dart' as _i47;
import '../../presentation/blocs/transaction/transaction_bloc.dart' as _i937;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i302.TransactionRepository>(
      () => _i468.TransactionRepositoryImpl(),
    );
    gh.lazySingleton<_i290.PaymentMethodRepository>(
      () => _i879.PaymentMethodRepositoryImpl(),
    );
    gh.lazySingleton<_i485.CategoryRepository>(
      () => _i383.CategoryRepositoryImpl(),
    );
    gh.factory<_i47.GetAllTransactions>(
      () => _i47.GetAllTransactions(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.GetTransactionsByDateRange>(
      () => _i47.GetTransactionsByDateRange(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.GetTransactionsByCategory>(
      () => _i47.GetTransactionsByCategory(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.AddTransaction>(
      () => _i47.AddTransaction(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.UpdateTransaction>(
      () => _i47.UpdateTransaction(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.DeleteTransaction>(
      () => _i47.DeleteTransaction(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i47.SearchTransactions>(
      () => _i47.SearchTransactions(gh<_i302.TransactionRepository>()),
    );
    gh.factory<_i937.TransactionBloc>(
      () => _i937.TransactionBloc(
        gh<_i47.GetAllTransactions>(),
        gh<_i47.GetTransactionsByDateRange>(),
        gh<_i47.GetTransactionsByCategory>(),
        gh<_i47.AddTransaction>(),
        gh<_i47.UpdateTransaction>(),
        gh<_i47.DeleteTransaction>(),
        gh<_i47.SearchTransactions>(),
      ),
    );
    return this;
  }
}
