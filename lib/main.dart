import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlCountryCodePicker countryPicker;
  final _phoneController = TextEditingController();
  CountryCode? countryCode;

  @override
  void initState() {
    final favoriteCountries = ['CA', 'BR', 'GE', 'JP'];
    countryPicker = FlCountryCodePicker(
      favorites: favoriteCountries,
      favoritesIcon: const Icon(
        Icons.star,
        color: Colors.amber,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child:
                          countryCode != null ? countryCode!.flagImage : null,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final code =
                            await countryPicker.showPicker(context: context);
                        setState(() {
                          countryCode = code;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            countryCode?.dialCode ?? "+1",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
              labelText: "Enter you phone number",
              labelStyle: TextStyle(
                color: Colors.grey[900],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              if (countryCode?.code != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${countryCode!.dialCode}-${_phoneController.text.trim()}")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please select a country code")));
              }
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
