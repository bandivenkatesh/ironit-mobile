/// Support Card
/// Reusable widget for FAQ/support items
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SupportCard extends StatefulWidget {
  final String question;
  final String answer;

  const SupportCard({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<SupportCard> createState() => _SupportCardState();
}

class _SupportCardState extends State<SupportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Column(
        children: <Widget>[
          // Question header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.medium),
              topRight: Radius.circular(AppSpacing.medium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.question,
                      style: AppTypography.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 24,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          // Answer content (expanded)
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.medium,
                0,
                AppSpacing.medium,
                AppSpacing.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Divider(),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    widget.answer,
                    style: AppTypography.bodyText1.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                ],
              ),
            ),
        ],
      ),
    );
  }
}