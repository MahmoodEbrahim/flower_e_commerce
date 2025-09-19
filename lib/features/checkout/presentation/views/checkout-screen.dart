import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/update_screen.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/checkout/presentation/view_model/view_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:flower_e_commerce/features/payment/presentation/view_model/checkout_view_model_bloc.dart';
import 'package:flower_e_commerce/features/payment_view/presentation/views/pages/PaymentViewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  final CartEntity cart;
  const CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "cash";
  ValueNotifier<int?> selectedAddress = ValueNotifier<int?>(null);
  bool isGift = false;
  final ValueNotifier<int> price = ValueNotifier<int>(0);
  late UserModel userModel;
  late LoginModel? loginModel;
  late List<AddressEntity> address;
    bool isAddFound = false;

  @override
  void initState() {
    UserModel userModel =BlocProvider.of<SettingCubit>(context).userModel!;
    print(userModel.addresses);
    if (userModel.addresses.isNotEmpty) {
    address = userModel.addresses;
    isAddFound=true;
    }
   
    super.initState();
  }
final viewmodel=getIt.get<CheckoutViewModelBloc>();
  @override
  Widget build(BuildContext context) {
  
  

   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Checkout"),
        leading: const BackButton(),
      ),
      body: BlocProvider.value(
          value: viewmodel,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery time", style: TextStyle(fontSize: 16)),
                Text(
                  "Schedule",
                  style: TextStyle(color: Colors.pink[400], fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Text("Instant,", style: TextStyle(color: Colors.black)),
                      Text(
                        " Arrive by 03 Sep 2024, 11:00 AM",
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text(
              "Delivery address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            if (isAddFound)
              SizedBox(
                height: 220.h,
                child: ValueListenableBuilder<int?>(
                  valueListenable: selectedAddress,
                  builder: (context, selectedIndex, _) {
                    return ListView.separated(
                      itemCount: address.length,
                      itemBuilder: (context, index) {
                        return _addressOption(
                          index,
                          address[index],
                          selectedIndex,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10.h);
                      },
                    );
                  },
                ),
              ),

            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addAddress);
              },
              icon: const Icon(Icons.add, color: Colors.pink),
              label: const Text(
                "Add new",
                style: TextStyle(color: Colors.pink),
              ),
            ),
            const Divider(height: 32),
            const Text(
              "Payment method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _paymentOption("cash", "Cash on delivery"),
            const SizedBox(height: 8),
            _paymentOption("card", "Credit card"),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("It is a gift"),
                Switch(
                  value: isGift,
                  onChanged: selectedPayment == "cash"
                      ? null
                      : (val) {
                    setState(() {
                      isGift = val;
                    });
                  },
                  activeColor: Colors.pink,
                ),
              ],
            ),
            if (isGift && selectedPayment != "cash") ...[
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter the name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Phone number",
                  hintText: "Enter the phone number",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sub Total"),
                Text("${widget.cart.totalPrice}\$"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Delivery Fee"), Text("${10}\$")],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "${widget.cart.totalPrice! + 10}\$",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
         isAddFound?   const SizedBox(height: 24):  SizedBox(height: 160.h),
            SizedBox(
              width: double.infinity,
              height: 50,
              child:BlocListener<CheckoutViewModelBloc,
                  CheckoutViewModelState>(listener: (context,state){
                if(state is PaymentOnlineStates ){
                  Navigator.of(context).pushNamed(AppRoutes.paymentView,
                      arguments:state.frame);
                }
              },
              child:   ValueListenableBuilder(
                valueListenable:selectedAddress,
                  builder: (context,index,child)
                  =>       ElevatedButton(
                    onPressed:
                    isAddFound && selectedAddress.value!=null?  () {
                      if(selectedPayment=="cash"){
                        viewmodel.add(
                            PayCashOrderEvent(CashOrderRequest(
                                shippingAddress:
                                ShippingAddress(
                                  street: address[selectedAddress.value!].street,
                                  city:address[selectedAddress.value!].city,
                                  long:address[selectedAddress.value!].long,
                                  lat: address[selectedAddress.value!].lat,
                                  phone: address[selectedAddress.value!].phone,
                                )
                            )));
                        Navigator.of(context).pushNamed(AppRoutes.orderspage);
                      }else{
                        viewmodel.add(PayOnlineOrderEvent
                          ( CashOrderRequest(
                            shippingAddress:
                            ShippingAddress(
                              street: address[selectedAddress.value!].street,
                              city:address[selectedAddress.value!].city,
                              long:address[selectedAddress.value!].long,
                              lat: address[selectedAddress.value!].lat,
                              phone: address[selectedAddress.value!].phone,
                            )
                        )));

                      }
                    }:null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:isAddFound&& selectedAddress.value!=null
                          ?AppColors.pink:AppColors.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Place order",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),)

              )

            ),
          ],
        ),
      )
      )

    );
  }

  Widget _addressOption(int index, AddressEntity address, int? selectedIndex) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          selectedAddress.value = index;
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedIndex == index
                  ? Colors.pink
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Radio<int>(
              value: index,
              groupValue: selectedIndex,
              activeColor: Colors.pink,
              onChanged: (val) {
                selectedAddress.value = val;
              },
            ),
            title: Text(address.city ?? ""),
            subtitle: Text(address.street ?? ""),
            trailing: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateAddressDetailsScreen(address: address),
                  ),
                );
              },
              child: Icon(Icons.edit, size: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentOption(String value, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
          if (value == "cash") {
            isGift = false; // reset gift if cash selected
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPayment == value
                ? Colors.pink
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Radio(
            value: value,
            groupValue: selectedPayment,
            activeColor: Colors.pink,
            onChanged: (val) {
              setState(() {
                selectedPayment = val.toString();
                if (val == "cash") {
                  isGift = false;
                }
              });
            },
          ),
          title: Text(title),
        ),
      ),
    );
  }

}
