import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "cash";
  String selectedAddress = "home";
  bool isGift = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery time", style: TextStyle(fontSize: 16)),
                Text("Schedule",
                    style: TextStyle(color: Colors.pink[400], fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Instant, Arrive by 03 Sep 2024, 11:00 AM",
                    style: TextStyle(color: Colors.green[700]),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text("Delivery address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _addressOption("home", "Home", "2XVP-XC - Sheikh Zayed"),
            const SizedBox(height: 8),
            _addressOption("office", "Office", "2XVP-XC - Sheikh Zayed"),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.pink),
              label: const Text("Add new",
                  style: TextStyle(color: Colors.pink)),
            ),
            const Divider(height: 32),
            const Text("Payment method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              children: const [
                Text("Sub Total"),
                Text("100\$"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Delivery Fee"),
                Text("10\$"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("110\$", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Place order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressOption(String value, String title, String subtitle) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedAddress = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedAddress == value ? Colors.pink : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Radio(
            value: value,
            groupValue: selectedAddress,
            activeColor: Colors.pink,
            onChanged: (val) {
              setState(() {
                selectedAddress = val.toString();
              });
            },
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.edit, size: 20),
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
            color: selectedPayment == value ? Colors.pink : Colors.grey.shade300,
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
