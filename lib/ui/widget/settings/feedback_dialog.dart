import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackDialog extends ConsumerWidget {
  final String title;
  final String subject;
  final TextEditingController controller = TextEditingController();

  FeedbackDialog({super.key, required this.title, required this.subject});

  void _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ilian.coding@gmail.com',
      queryParameters: {
        'subject': subject,
        'body': controller.text,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      if (!context.mounted) return;
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send $emailUri')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: AppLocalizations.of(context)!.feedback,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            _sendEmail(context);
          },
          child: Text(AppLocalizations.of(context)!.submit),
        ),
      ],
    );
  }
}