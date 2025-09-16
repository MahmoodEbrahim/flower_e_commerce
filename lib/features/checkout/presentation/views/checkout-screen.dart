import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final int subTotal;
  final int deliveryFee;

  const CheckoutScreen({
    Key? key,
    this.subTotal = 0,
    this.deliveryFee = 0,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "cash";
  String selectedAddress = "home";
  bool isGift = false;
  bool isPlacingOrder = false;

  // controllers للـ gift
  final TextEditingController giftNameController = TextEditingController();
  final TextEditingController giftPhoneController = TextEditingController();

  // Notifiers للـ مبالغ
  late ValueNotifier<int> subTotalNotifier;
  late ValueNotifier<int> deliveryNotifier;

  @override
  void initState() {
    subTotalNotifier = ValueNotifier<int>(widget.subTotal);
    deliveryNotifier = ValueNotifier<int>(widget.deliveryFee);
    super.initState();
  }

  @override
  void dispose() {
    subTotalNotifier.dispose();
    deliveryNotifier.dispose();
    giftNameController.dispose();
    giftPhoneController.dispose();
    super.dispose();
  }

  int get total => subTotalNotifier.value + deliveryNotifier.value;

  Future<void> placeOrder() async {
    // validation
    if (isGift && selectedPayment != "cash") {
      final name = giftNameController.text.trim();
      final phone = giftPhoneController.text.trim();
      if (name.isEmpty || phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter gift name and phone.")),
        );
        return;
      }
    }

    setState(() => isPlacingOrder = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      setState(() => isPlacingOrder = false);

      // عرض Dialog نجاح
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Order placed"),
          content: const Text("Your order has been placed successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).pop(true); // رجوع للصفحة السابقة (ترجع true)
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() => isPlacingOrder = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to place order: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Delivery time row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Delivery time", style: TextStyle(fontSize: 16)),
              Text("Schedule", style: TextStyle(color: Colors.pink[400], fontSize: 16)),
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
                    Text(" Arrive by 03 Sep 2024, 11:00 AM", style: TextStyle(color: Colors.green[700])),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),

          // Delivery address
          const Text("Delivery address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _addressOption("home", "Home", "2XVP+XC - Sheikh Zayed"),
          const SizedBox(height: 8),
          _addressOption("office", "Office", "2XVP+XC - Sheikh Zayed"),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              // افتح صفحة إضافة عنوان أو أديالوج
            },
            icon: const Icon(Icons.add, color: Colors.pink),
            label: const Text("Add new", style: TextStyle(color: Colors.pink)),
          ),
          const Divider(height: 32),

          // Payment method
          const Text("Payment method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _paymentOption("cash", "Cash on delivery"),
          const SizedBox(height: 8),
          _paymentOption("card", "Credit card"),
          const Divider(height: 32),

          // It is a gift
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("It is a gift"),
              Opacity(
                opacity: selectedPayment == "cash" ? 0.6 : 1.0, // make it look disabled when cash
                child: Switch(
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
              ),
            ],
          ),

          // gift fields conditionally
          if (isGift && selectedPayment != "cash") ...[
            const SizedBox(height: 8),
            TextField(
              controller: giftNameController,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter the name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: giftPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone number",
                hintText: "Enter the phone number",
                border: OutlineInputBorder(),
              ),
            ),
          ],

          const Divider(height: 32),

          // Summary (use ValueListenableBuilder)
          ValueListenableBuilder<int>(
            valueListenable: subTotalNotifier,
            builder: (context, st, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text("Sub Total"), Text("$st\$")],
                  ),
                  const SizedBox(height: 6),
                  ValueListenableBuilder<int>(
                    valueListenable: deliveryNotifier,
                    builder: (context, d, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text("Delivery Fee"), Text("$d\$")],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${subTotalNotifier.value + deliveryNotifier.value}\$", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // Place order button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isPlacingOrder ? null : placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: isPlacingOrder
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Place order", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _addressOption(String value, String title, String subtitle) {
    final bool selected = selectedAddress == value;
    return GestureDetector(
      onTap: () => setState(() => selectedAddress = value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.pink : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Radio<String>(
            value: value,
            groupValue: selectedAddress,
            activeColor: Colors.pink,
            onChanged: (val) => setState(() => selectedAddress = val ?? value),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.edit, size: 20),
        ),
      ),
    );
  }

  Widget _paymentOption(String value, String title) {
    final bool selected = selectedPayment == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
          if (value == "cash") {
            isGift = false;
            giftNameController.clear();
            giftPhoneController.clear();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.pink : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Radio<String>(
            value: value,
            groupValue: selectedPayment,
            activeColor: Colors.pink,
            onChanged: (val) {
              setState(() {
                selectedPayment = val ?? value;
                if (selectedPayment == "cash") {
                  isGift = false;
                  giftNameController.clear();
                  giftPhoneController.clear();
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
