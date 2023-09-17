import 'package:flutter/material.dart';

class GeneralError extends StatelessWidget {
  final String? errrorText;
  const GeneralError({super.key, this.errrorText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
      child: Center(
        child: Text(errrorText ?? "Server Error!"),
      ),
    );
  }
}
