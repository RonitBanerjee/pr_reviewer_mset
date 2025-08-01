import 'package:flutter/material.dart';
import 'package:pr_reviewer/constants/theme_colors.dart';
import 'package:pr_reviewer/models/pull_request.dart';

class PrCard extends StatefulWidget {
  final PullRequest prData;

  const PrCard({super.key, required this.prData});

  @override
  State<PrCard> createState() => _PrCardState();
}

class _PrCardState extends State<PrCard> {
  late bool isDarkMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurStyle: BlurStyle.normal,
            blurRadius: 5,
            offset: Offset(2, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: ThemeColors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.prData.status.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.prData.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 8),

            if (widget.prData.body != null)
              Text(
                widget.prData.body,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 32, 3, 56),
                ),
              ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '@${widget.prData.author}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.blueGrey),
                ),
                Text(
                  'Opened on ${_formatDate(widget.prData.createdAt)}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}st ${_monthName(date.month)}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
