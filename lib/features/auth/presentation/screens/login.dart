import 'package:clean_architecture_bloc/features/products/presentation/screens/product_list.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: "johnd");
  final TextEditingController passwordController = TextEditingController(text: "m38rmF");
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Email and password cannot be empty');
      return;
    }

    setState(() => isLoading = true);

    // Simulate login process
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    // Navigate to products page on success
    if (mounted) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (_) => const ProductPage()),
      );
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Apple-style logo
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: CupertinoColors.label,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.person_solid,
                    color: CupertinoColors.systemBackground,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // Welcome text
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.label,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.secondaryLabel,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Email field
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemGroupedBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoTextField(
                  controller: emailController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  placeholder: 'Email',
                  placeholderStyle: const TextStyle(
                    color: CupertinoColors.placeholderText,
                    fontSize: 17,
                  ),
                  style: const TextStyle(fontSize: 17),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                  decoration: const BoxDecoration(),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemGroupedBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoTextField(
                  controller: passwordController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  placeholder: 'Password',
                  placeholderStyle: const TextStyle(
                    color: CupertinoColors.placeholderText,
                    fontSize: 17,
                  ),
                  style: const TextStyle(fontSize: 17),
                  obscureText: true,
                  enabled: !isLoading,
                  decoration: const BoxDecoration(),
                ),
              ),
              const SizedBox(height: 32),

              // Sign in button
              SizedBox(
                height: 56,
                child: CupertinoButton.filled(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(16),
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white,
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Forgot password
              CupertinoButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemBlue,
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
