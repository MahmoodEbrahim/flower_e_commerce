
import 'package:flower_e_commerce/features/tracking_order/domain/entity/driver_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/order_entity.dart';


class RemoteDataEntity {
  final OrderEntity orderEntity;
  final DriverEntity driverEntity; // came from function get logged driver
  final String? orderDeliveryStatus;

  RemoteDataEntity(this.driverEntity, this.orderEntity, this.orderDeliveryStatus);
}
