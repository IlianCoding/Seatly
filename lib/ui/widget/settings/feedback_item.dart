import 'package:flutter/material.dart';
import 'package:seatly/ui/widget/settings/feedback_dialog.dart';

class FeedbackItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  const FeedbackItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });

  void _showFeedbackDialog(BuildContext context, String title, String subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackDialog(
          title: title,
          subject: subject,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              _showFeedbackDialog(context, title, title);
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}