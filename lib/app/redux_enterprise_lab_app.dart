import 'package:flutter/material.dart';

// import '../features/counter/presentation/counter_page.dart';
import '../features/counter/presentation/counter_page2.dart';

class ReduxEnterpriseLabApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redux Enterprise Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: CounterPage2(),
      // routes: {'/counter': (context) => CounterPage()},
    );
  }
}
