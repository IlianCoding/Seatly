import 'package:flutter/material.dart';

class InfoDescription extends StatelessWidget {
  final String description;
  final String skipButtonText;
  final String nextButtonText;
  final void Function()? onSkip;
  final void Function()? onNext;

  const InfoDescription({
    super.key,
    required this.description,
    required this.skipButtonText,
    required this.nextButtonText,
    this.onSkip,
    this.onNext,
  });

  @override

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onSkip, child: Text(skipButtonText)),
              const SizedBox(width: 16.0),
              ElevatedButton(onPressed: onNext, child: Text(nextButtonText)),
            ],
          )
        ],
      ),
    );
  }
}