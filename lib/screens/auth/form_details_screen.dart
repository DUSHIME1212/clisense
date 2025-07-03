import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:clisence/main.dart';

class FormDetailsScreen extends StatefulWidget {
  const FormDetailsScreen({super.key});

  @override
  State<FormDetailsScreen> createState() => _FormDetailsScreenState();
}

class _FormDetailsScreenState extends State<FormDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _districtController = TextEditingController(); // Separate district field
  String? _selectedCountry; // For country dropdown

  // Replace with your Geoapify API key
  final String _apiKey = '6d08cec3e2b7492f9d3404a99dbc93fe';

  // Preload a list of countries
  final List<String> _countries = ['Kenya', 'Uganda', 'Tanzania', 'Rwanda'];

  void _printText(String text) {
    print('Input: $text');
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +254712345678)';
    }
    return null;
  }

  // Fetch district suggestions (optional validation)
  Future<void> _fetchDistrictSuggestions(String country, String district) async {
    if (country.isEmpty || district.isEmpty) return;

    final url = Uri.parse(
      'https://api.geoapify.com/v1/geocode/search?text=$district,$country&apiKey=$_apiKey&limit=1',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final features = data['features'] as List<dynamic>?;
        if (features != null && features.isNotEmpty) {
          final properties = features[0]['properties'];
          final fetchedDistrict = properties['county'] ?? properties['district'] ?? 'Not available';
          if (fetchedDistrict != _districtController.text) {
            setState(() {
              _districtController.text = fetchedDistrict;
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching district: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _farmNameController.addListener(() => _printText(_farmNameController.text));
    _phoneNumberController.addListener(() => _printText(_phoneNumberController.text));
    _districtController.addListener(() {
      _printText(_districtController.text);
      if (_selectedCountry != null) {
        _fetchDistrictSuggestions(_selectedCountry!, _districtController.text);
      }
    });
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _phoneNumberController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Additional Details',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          elevation: 4,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add details to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Farm Name', _farmNameController, _validateField),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                    items: _countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() => _selectedCountry = value);
                    },
                    validator: (value) => value == null ? 'Please select a country' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('District', _districtController, _validateField),
                  const SizedBox(height: 20),
                  _buildTextField('Phone Number', _phoneNumberController, _validatePhone),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form details saved, proceeding to splash');
                          context.go(AppRoutes.home);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'SAVE AND CONTINUE',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
      maxLines: 1,
    );
  }
}