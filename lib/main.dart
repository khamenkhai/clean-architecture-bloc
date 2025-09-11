import 'package:clean_architecture_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_architecture_bloc/features/auth/presentation/screens/login.dart';
import 'package:clean_architecture_bloc/features/products/presentation/bloc/product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service_locator.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
        BlocProvider<ProductCubit>(create: (_) => di.sl<ProductCubit>()),
      ],
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.activeBlue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
