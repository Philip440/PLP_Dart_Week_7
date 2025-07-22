import 'package:flutter/material.dart';

class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedMethod = 'Mobile Money';
  bool _isFavorite = false;
  bool _showSuccess = false;

  List<String> paymentMethods = ['Mobile Money', 'Bank Transfer', 'Cash'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccess = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _showSuccess = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Recipient Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Recipient name is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Amount
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Payment Method Dropdown
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                items: paymentMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedMethod = value!),
                decoration: InputDecoration(labelText: 'Payment Method'),
              ),

              SizedBox(height: 16),

              // Favorite Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mark as Favorite'),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) => setState(() => _isFavorite = value),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Reusable Custom Button
              SendMoneyButton(
                onPressed: _submitForm,
                label: "Send",
              ),

              SizedBox(height: 20),

              // Animated Success Message
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _showSuccess ? 1.0 : 0.0,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Transaction Successful!',
                          style: TextStyle(color: Colors.green[900])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
