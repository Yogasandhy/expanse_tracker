import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_method_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/local_dummy_data_source.dart';

@LazySingleton(as: PaymentMethodRepository)
class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  @override
  Future<Either<Failure, List<PaymentMethod>>> getAllPaymentMethods() async {
    try {
      final paymentMethods = LocalDummyDataSource.paymentMethods;
      return Right(paymentMethods);
    } catch (e) {
      return const Left(CacheFailure('Failed to get payment methods'));
    }
  }

  @override
  Future<Either<Failure, PaymentMethod>> getPaymentMethodById(String id) async {
    try {
      final paymentMethod = LocalDummyDataSource.paymentMethods
          .firstWhere((method) => method.id == id);
      
      return Right(paymentMethod);
    } catch (e) {
      return const Left(NotFoundFailure('Payment method not found'));
    }
  }
}
