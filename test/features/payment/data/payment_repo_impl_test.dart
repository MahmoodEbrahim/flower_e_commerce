// import 'package:flower_e_commerce/core/api_result/api_result.dart';
// import 'package:flower_e_commerce/features/payment/api/models/cash_order_responce_model.dart';
// import 'package:flower_e_commerce/features/payment/api/models/online_payment_responce_model.dart';
// import 'package:flower_e_commerce/features/payment/api/models/session_model.dart';
// import 'package:flower_e_commerce/features/payment/data/repository/payment_repository_imp.dart';
// import 'package:flower_e_commerce/features/payment/data/source/payment_remote_data_source.dart';
// import 'package:flower_e_commerce/features/payment/domain/entity/cash_payment_responce_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'payment_repo_impl_test.mocks.dart';

// @GenerateMocks([PaymentRemoteDataSource])
// void main() {
//   late PaymentRepositoryImpl paymentRepository;
//   late MockPaymentRemoteDataSource mockPaymentdataSource;
//   late CashOrderResponce cashOrderResponce;
//   late OnlinePaymentResponce onlinePaymentResponce;

//   setUpAll(() {
//     mockPaymentdataSource = MockPaymentRemoteDataSource();
//     paymentRepository = PaymentRepositoryImpl(mockPaymentdataSource);
//     cashOrderResponce = CashOrderResponce(message: "order created successfully");
//     onlinePaymentResponce = OnlinePaymentResponce(
//         session: Session(id: "sess_123", url: "https://payment.url"));
//     provideDummy<ApiResult<OnlinePaymentResponce>>(ApiSucessResult(onlinePaymentResponce));
//     provideDummy<ApiResult<CashOrderResponce>>(ApiSucessResult(cashOrderResponce));
//   });

//   group('test createCashOrder in PaymentRepoImpl', () {
//     test(
//         'should return ApiSuccessResult with CashPaymentResponce on success',
//             () async {
//           // 1. Arrange: Mock the successful API call.
//           when(mockPaymentdataSource.createCashOrder(any))
//               .thenAnswer((_) async => ApiSucessResult(cashOrderResponce));

//           // 2. Act: Call the method.
//           final result = await paymentRepository.createCashOrder({});

//           // 3. Assert: Verify the result.
//           expect(result, isA<ApiSucessResult<CashPaymentResponceEntity>>());
//           final data = (result as ApiSucessResult).sucessResult;
//           expect(data, isA<CashPaymentResponceEntity>());
//           expect(data.message, 'order created successfully');
//           verify(mockPaymentdataSource.createCashOrder({})).called(1);
//         });

//     test('should return ApiFailedResult on failure', () async {
//       // 1. Arrange: Mock the failed API call.
//       when(mockPaymentdataSource.createCashOrder(any))
//           .thenAnswer((_) async => ApiFailedResult("error"));

//       // 2. Act: Call the method.
//       final result = await paymentRepository.createCashOrder({});

//       // 3. Assert: Verify the result.
//       expect(result, isA<ApiFailedResult>());
//       final message = (result as ApiFailedResult);
//       expect(message.errorMessage, 'error');
//       verify(mockPaymentdataSource.createCashOrder({})).called(1);
//     });
//   });
//   group("test Create Online Order in PaymentRepoImpl",(){
// test("return ApiSucessResult with session url",()async{
//   when(mockPaymentdataSource.createOnlineOrder(any))
//       .thenAnswer((_) async => ApiSucessResult(onlinePaymentResponce));
//   final result=await paymentRepository.createOnlineOrder({});
//   expect(result,isA<ApiSucessResult<String>>());
//   final data=(result as ApiSucessResult).sucessResult;
//   expect(data,isA<String>());
//   expect(data,"https://payment.url");
//   verify(mockPaymentdataSource.createOnlineOrder({})).called(1);
// } );
// test("return ApiFailedResult on failure",()async{
//   when(mockPaymentdataSource.createOnlineOrder(any))
//       .thenAnswer((_) async => ApiFailedResult("error"));
//   final result=await paymentRepository.createOnlineOrder({});
//   expect(result, isA<ApiFailedResult<String>>());
//   final message = (result as ApiFailedResult);
//   expect(message.errorMessage, 'error');
//   verify(mockPaymentdataSource.createOnlineOrder({})).called(1);
// });


//   });
// }