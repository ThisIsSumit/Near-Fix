import 'package:flutter/material.dart';
import 'package:near_fix/services/auth__service.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userType = 'customer';
  bool isLoading = false;

  Future<void> _signup() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      await AuthService().signUp(
        _emailController.text,
        _passwordController.text,
        _userType,
        _phoneController.text,
      );
      String userId = AuthService().getUserId()!;

      if (_userType == 'customer') {
        Navigator.pushReplacementNamed(context, '/customer-home');
      } else {
        Navigator.pushReplacementNamed(context, '/provider-home');
      }
    } catch (e) {
      // Handle error
      print('Signup error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please fill in the details below",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 32),

                  // User Type Selection
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "I am a:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            // Customer option
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text(
                                  "Customer",
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: 'customer',
                                groupValue: _userType,
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value!;
                                  });
                                },
                              ),
                            ),
                            // Provider option
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text(
                                  "Service Provider",
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: 'provider',
                                groupValue: _userType,
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    onChanged: (value) {
                      _nameController.text = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppColors.textLight,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    onChanged: (value) {
                      _emailController.text = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.textLight,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Phone Field
                  TextFormField(
                    controller: _phoneController,
                    onChanged: (value) {
                      _phoneController.text = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: AppColors.textLight,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (value) {
                      _passwordController.text = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.textLight,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: AppColors.textLight,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),

                  // Signup Button
                  isLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                        text: "Create Account",
                        onPressed: () {
                          _signup();
                        },
                      ),
                  SizedBox(height: 24),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
