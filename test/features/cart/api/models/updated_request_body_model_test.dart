import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/cart/api/models/updated_request_body_model.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';

void main() {

  
    test('should return a model with correct quantity when entity has fake data', () {
      // arrange
      final UpdatedRequestBodyEntity fakeEntity = UpdatedRequestBodyEntity(quantity: 5);

      // act
      final model = UpdatedRequestBodyModel.toModel(fakeEntity);

      // assert
      expect(model.quantity, 5);
    });
  }

