import 'package:flutter/material.dart';

class GeneralLoading extends StatelessWidget {
  const GeneralLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
