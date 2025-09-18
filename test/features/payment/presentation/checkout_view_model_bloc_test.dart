// test/features/payment/presentation/view_model/checkout_view_model_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/payment/domain/entity/cash_payment_responce_entity.dart';
import 'package:flower_e_commerce/features/payment/domain/usecase/cash_use_case.dart';
import 'package:flower_e_commerce/features/payment/domain/usecase/online_usecase.dart';
import 'package:flower_e_commerce/features/payment/presentation/view_model/checkout_view_model_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockCashUseCase extends Mock implements CashUseCase {}
class MockOnlineUseCase extends Mock implements OnlineUsecase {}

void main() {

  late CheckoutViewModelBloc checkoutViewModelBloc;
  late MockCashUseCase mockCashUseCase;
  late MockOnlineUseCase mockOnlineUseCase;

  setUp(() {
    mockCashUseCase = MockCashUseCase();
    mockOnlineUseCase = MockOnlineUseCase();
    checkoutViewModelBloc = CheckoutViewModelBloc(mockCashUseCase, mockOnlineUseCase);
  });


  group('payCashOrder', () {
    final Map<String, dynamic> dummyOrder = {};
    const CashPaymentResponceEntity dummyEntity = CashPaymentResponceEntity(message: "Success");

    blocTest<CheckoutViewModelBloc, CheckoutViewModelState>(
      'should emit [PaymentCashStates(isLoading: true), PaymentCashStates(isLoading: false, cashPaymentResponceEntity)] on successful cash payment',

      setUp: () {
        when(() => mockCashUseCase.invoke(dummyOrder))
            .thenAnswer((_) async => ApiSucessResult(dummyEntity));
      },
      build: () => checkoutViewModelBloc,
      act: (bloc) => bloc.add(PayCashOrderEvent(dummyOrder)),

      expect: () => [
        PaymentCashStates(isLoading: true),
        PaymentCashStates(isLoading: false, cashPaymentResponceEntity: dummyEntity),
      ],
    );

    blocTest<CheckoutViewModelBloc, CheckoutViewModelState>(
      'should emit [PaymentCashStates(isLoading: true), PaymentCashStates(isLoading: false, errorMessage)] on failed cash payment',

      setUp: () {
        when(() => mockCashUseCase.invoke(dummyOrder))
            .thenAnswer((_) async => ApiFailedResult("Error message"));
      },

      build: () => checkoutViewModelBloc,
      act: (bloc) => bloc.add(PayCashOrderEvent(dummyOrder)),

      expect: () => [
        PaymentCashStates(isLoading: true),
        PaymentCashStates(isLoading: false, errorMessage: "Error message"),
      ],
    );
  });


  group('payOnlineOrder', () {
    final Map<String, dynamic> dummyOrder = {};
    const String dummyUrl = "http://example.com/payment";

    blocTest<CheckoutViewModelBloc, CheckoutViewModelState>(
      'should emit [PaymentOnlineStates(isLoading: true), PaymentOnlineStates(isLoading: false, frame)] on successful online payment',

      setUp: () {
        when(() => mockOnlineUseCase.invoke(dummyOrder))
            .thenAnswer((_) async => ApiSucessResult(dummyUrl));
      },

      build: () => checkoutViewModelBloc,
      act: (bloc) => bloc.add(PayOnlineOrderEvent(dummyOrder)),

      expect: () => [
        PaymentOnlineStates(isLoading: true),
        PaymentOnlineStates(isLoading: false, frame: dummyUrl),
      ],
    );

    blocTest<CheckoutViewModelBloc, CheckoutViewModelState>(
      'should emit [PaymentOnlineStates(isLoading: true), PaymentOnlineStates(isLoading: false, errorMessage)] on failed online payment',
      // 5. إعداد Mock للفشل
      setUp: () {
        when(() => mockOnlineUseCase.invoke(dummyOrder))
            .thenAnswer((_) async => ApiFailedResult("Error message"));
      },
      // 6. الحدث (Event)
      build: () => checkoutViewModelBloc,
      act: (bloc) => bloc.add(PayOnlineOrderEvent(dummyOrder)),
      // 7. النتائج المتوقعة (Expected states)
      expect: () => [
        PaymentOnlineStates(isLoading: true),
        PaymentOnlineStates(isLoading: false, errorMessage: "Error message"),
      ],
    );
  });
}