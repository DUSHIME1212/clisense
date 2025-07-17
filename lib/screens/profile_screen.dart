import 'package:flutter/material.dart';
import '../components/ui_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  // Mock user data (replace with real user model when available)
  String _name = 'Jane Doe';
  String _email = 'jane.doe@email.com';
  String _farmName = 'Green Acres';
  String _country = 'Kenya';
  String _district = 'Nairobi';
  String _phone = '+254712345678';

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _farmNameController;
  late TextEditingController _districtController;
  late TextEditingController _phoneController;
  String? _selectedCountry;

  final List<String> _countries = ['Kenya', 'Uganda', 'Tanzania', 'Rwanda'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
    _farmNameController = TextEditingController(text: _farmName);
    _districtController = TextEditingController(text: _district);
    _phoneController = TextEditingController(text: _phone);
    _selectedCountry = _country;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _farmNameController.dispose();
    _districtController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset fields if canceling edit
        _nameController.text = _name;
        _emailController.text = _email;
        _farmNameController.text = _farmName;
        _districtController.text = _district;
        _phoneController.text = _phone;
        _selectedCountry = _country;
      }
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _name = _nameController.text;
        _email = _emailController.text;
        _farmName = _farmNameController.text;
        _district = _districtController.text;
        _phone = _phoneController.text;
        _country = _selectedCountry ?? _country;
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIComponents.appBar(context, 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Profile header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Profile details (editable)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField('Name', _nameController, enabled: _isEditing, validator: _validateNotEmpty),
                    const SizedBox(height: 16),
                    _buildTextField('Email', _emailController, enabled: _isEditing, validator: _validateEmail, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildTextField('Farm Name', _farmNameController, enabled: _isEditing, validator: _validateNotEmpty),
                    const SizedBox(height: 16),
                    _buildCountryDropdown(),
                    const SizedBox(height: 16),
                    _buildTextField('District', _districtController, enabled: _isEditing, validator: _validateNotEmpty),
                    const SizedBox(height: 16),
                    _buildTextField('Phone', _phoneController, enabled: _isEditing, validator: _validatePhone, keyboardType: TextInputType.phone),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Edit/Save/Cancel buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isEditing)
                    ...[
                      UIComponents.primaryButton(context, 'Save', _saveProfile),
                      const SizedBox(width: 16),
                      UIComponents.secondaryButton(context, 'Cancel', _toggleEdit),
                    ]
                  else
                    UIComponents.primaryButton(context, 'Edit Profile', _toggleEdit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = false, String? Function(String?)? validator, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      maxLines: 1,
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      decoration: InputDecoration(
        labelText: 'Country',
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      items: _countries.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: _isEditing
          ? (String? value) {
              setState(() => _selectedCountry = value);
            }
          : null,
      validator: (value) => value == null ? 'Please select a country' : null,
      disabledHint: Text(_selectedCountry ?? ''),
    );
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4} 24').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\+?[\d\s-]{10,} 24').hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +254712345678)';
    }
    return null;
  }
}
