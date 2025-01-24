import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Consumer Widget not state bro

final hello = Provider<String>((ref){
  return 'Radhe Radhe from hello';
});

final age = Provider<int>((ref){
  return 24;
});



class PractiseOne extends ConsumerStatefulWidget {
  const PractiseOne({super.key});

  @override
  ConsumerState<PractiseOne> createState() => _PractiseOneState();
}

class _PractiseOneState extends ConsumerState<PractiseOne> {

  @override
  Widget build(BuildContext context) {
    final greeting = ref.watch(hello);
    final  myAge = ref.watch(age);
    return Scaffold(
        body: Center(
          child: Text(greeting),
        ),
    );
  }
}

// class PractiseOne extends ConsumerWidget {
//   const PractiseOne({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final greeting = ref.watch(hello);
//     final  myAge = ref.watch(age);
//     return Scaffold(
//         body: Center(
//           child: Text(greeting),
//         ),
//     );
//   }
// }
