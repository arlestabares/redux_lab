// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux_enterprise_lab/features/counter/redux/counter_actions.dart';

// class CounterPage extends StatelessWidget {
//   const new({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Redux Enterprise Lab")),
//       body: Center(
//         child: StoreConnector<int, int>(
//           converter: (store) => store.state,
//           builder: (context, acount) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Contador redux', style: TextStyle(fontSize: 24)),
//                 SizedBox(height: 16),
//                 Text(
//                   '$acount',
//                   style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 24),
//                 Wrap(
//                   alignment: WrapAlignment.center,
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: [
//                     IconButton.filled(
//                       tooltip: 'Decrememntar',
//                       icon: Icon(Icons.remove),
//                       onPressed: () {
//                         StoreProvider.of<int>(context)
//                             .dispatch(const DecrementCounterAction());
//                       },
//                     ),
//                     IconButton.filled(
//                       tooltip: 'Incrementar',
//                       onPressed: () {
//                         StoreProvider.of<int>(context)
//                             .dispatch(const IncrementCounterAction());
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                     OutlinedButton(
//                       onPressed: () {
//                         StoreProvider.of<int>(context)
//                             .dispatch(const ResetCounterAction());
//                       },
//                       child: Text('Reinicar'),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
