import 'package:dartz/dartz.dart';
import '../entities/payment_method.dart';
import '../../core/error/failures.dart';

abstract class PaymentMethodRepository {
  Future<Either<Failure, List<PaymentMethod>>> getAllPaymentMethods();
  Future<Either<Failure, PaymentMethod>> getPaymentMethodById(String id);
}
