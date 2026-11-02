import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/theme_extension.dart';

class ListTileSwitchWidget extends StatelessWidget {
  const ListTileSwitchWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: context.colorScheme.primary,
        ),
      ],
    );
    // return ListTile(
    //   leading: icon,
    //   title: Text(
    //     title,
    //     style: context.theme.textTheme.bodyMedium?.copyWith(
    //       fontWeight: FontWeight.w600,
    //       color: context.colorScheme.onSurface,
    //     ),
    //   ),
    //   subtitle: Text(
    //     subtitle,
    //     style: context.theme.textTheme.labelMedium?.copyWith(
    //       color: context.colorScheme.onSurfaceVariant,
    //     ),
    //   ),
    //   trailing: Switch(
    //     value: value,
    //     onChanged: onChanged,
    //     activeTrackColor: context.colorScheme.primary,
    //   ),
    // );
  }
}
