import 'package:flutter/material.dart';
import '../../generated/slang/slang.g.dart';
import 'widgets.dart';

class GridSizeSelectorWidget extends StatelessWidget {
  final bool isVisible;
  final int selectedSize;
  final ValueChanged<int> onSizeChanged;
  final List<int> availableSizes;

  const GridSizeSelectorWidget({
    super.key,
    required this.isVisible,
    required this.selectedSize,
    required this.onSizeChanged,
    this.availableSizes = const [4, 5, 6, 7],
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      crossFadeState: isVisible
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: SectionCard(
          icon: Icons.straighten_rounded,
          title: context.t.settings.selected_size,
          child: Row(
            children: [
              for (int i = 0; i < availableSizes.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: TileWidget(
                    value: availableSizes[i],
                    title: '${availableSizes[i]}x${availableSizes[i]}',
                    isSelected: selectedSize == availableSizes[i],
                    onSelected: (value) {
                      onSizeChanged(value as int);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
