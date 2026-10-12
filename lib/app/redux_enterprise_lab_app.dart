import 'package:flutter/material.dart';

// import '../features/counter/presentation/counter_page.dart';
import '../features/counter/presentation/counter_page.dart';

class ReduxEnterpriseLabApp extends StatelessWidget {
  const ReduxEnterpriseLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redux Enterprise Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: CounterPage(),
      // routes: {'/counter': (context) => CounterPage()},
    );
  }
}
