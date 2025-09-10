import 'package:clean_architecture_bloc/core/utils/context_extension.dart';
import 'package:clean_architecture_bloc/features/products/presentation/screens/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class AppleLoginPage extends StatefulWidget {
  const AppleLoginPage({super.key});

  @override
  State<AppleLoginPage> createState() => _AppleLoginPageState();
}

class _AppleLoginPageState extends State<AppleLoginPage> {
  final TextEditingController nameController = TextEditingController(
    text: "johnd",
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'm38rmF',
  );

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final name = nameController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text('Email and password cannot be empty'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    // Trigger Cubit login
    context.read<AuthCubit>().login(name: name, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              // Show error dialog
              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: const Text('Login Failed'),
                  content: Text(state.message),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            } else if (state is AuthSuccess) {
              context.pushReplacement(ProductPage());
              // Navigate to next screen or show success
              // showCupertinoDialog(
              //   context: context,
              //   builder: (_) => CupertinoAlertDialog(
              //     title: const Text('Success'),
              //     content: Text('Logged in as ${state.user.token}'),
              //     actions: [
              //       CupertinoDialogAction(
              //         child: const Text('OK'),
              //         onPressed: () => Navigator.pop(context),
              //       )
              //     ],
              //   ),
              // );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: CupertinoColors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.person_solid,
                        color: CupertinoColors.white,
                        size: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email field
                  CupertinoTextField(
                    controller: nameController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  CupertinoTextField(
                    controller: passwordController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    placeholder: 'Password',
                    obscureText: true,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),

                  // Sign in button
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    borderRadius: BorderRadius.circular(12),
                    onPressed: isLoading ? null : _login,
                    child: isLoading
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white,
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
