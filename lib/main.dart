import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:paypal/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Paypal Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: RawMaterialButton(
                  shape: const CircleBorder(),
                  fillColor: Colors.orangeAccent,
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    BuildContext parentContext = context;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (parentContext) => UsePaypal(
                            sandboxMode: true,
                            clientId:myclientId,
                            secretKey: mysecretKey,
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions:  [
                              {
                                "amount": {
                                  "total": amount,
                                  "currency": "USD",
                                  "details": const {
                                    "subtotal": '1',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": amount,
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  "shipping_address": const {
                                    "recipient_name": "Jane Foster",
                                    "line1": "Travis County",
                                    "line2": "",
                                    "city": "Austin",
                                    "country_code": "US",
                                    "postal_code": "73301",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              setState(() {
                                _isLoading = false;
                                _message = 'Payment Successful';
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_message)));
                              });
                            },
                            onError: (error) {
                              setState(() {
                                _isLoading = false;
                                _message = 'Payment Failed';
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_message)));
                              });
                            },
                            onCancel: (params) {
                              setState(() {
                                _isLoading = false;
                                _message = 'Payment Canceled';
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_message)));
                              });
                            }),
                      ),
                    );
                  },
                  child: const Text(
                    'Donate',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            _isLoading ? const Center(child: CircularProgressIndicator()) : Container(),
          ],
        ),
      ),
    );
  }
}
