import 'package:mute_motion/core/errors/failures.dart';
import 'package:mute_motion/feature/orders_screen/view_model/orderModel.dart';
import 'package:dartz/dartz.dart';
abstract class OrderRepo {
  Future<Either<Failure,PendingOrder >> fetchNewsetOrder();

}