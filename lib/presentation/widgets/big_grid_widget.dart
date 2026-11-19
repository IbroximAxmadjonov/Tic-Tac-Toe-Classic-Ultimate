import 'package:flutter/material.dart';

import '../../domain/constants/enums.dart';
import '../../domain/entities/grid_items_entity.dart';

class BigGridWidget extends StatelessWidget {
  final GridItemsEntity gridItems;
  final List<Permission> permissionBigGridItems;
  final Function(int indexOfBigGrid, int indexOfSmallGrid) onTapped;

  const BigGridWidget({
    super.key,
    required this.gridItems,
    required this.permissionBigGridItems,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: gridItems.bigGridItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridItems.bigGridCrossAxisCount,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, indexOfBigGrid) {
        final smallGrid = SmallGridWidget(
          itemCount: gridItems.smallGridItems[indexOfBigGrid].length,
          crossAxisCount: gridItems.smallGridCrossAxisCount,
          indexOfBigGrid: indexOfBigGrid,
          symbol: gridItems.smallGridItems[indexOfBigGrid],
          onTapped: onTapped,
        );

        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: permissionBigGridItems[indexOfBigGrid] == Permission.permissible
                  ? Colors.green
                  : Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: gridItems.bigGridItems[indexOfBigGrid] != ''
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        gridItems.bigGridItems[indexOfBigGrid],
                        style: TextStyle(color: Colors.green, fontSize: 95),
                      ),
                    ),
                    smallGrid,
                  ],
                )
              : smallGrid,
        );
      },
    );
  }
}

class SmallGridWidget extends StatelessWidget {
  const SmallGridWidget({
    super.key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.indexOfBigGrid,
    required this.symbol,
    required this.onTapped,
  });

  final int itemCount;
  final int crossAxisCount;
  final int indexOfBigGrid;
  final List<String> symbol;
  final Function(int indexOfBigGrid, int indexOfSmallGrid) onTapped;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, indexOfSmallGrid) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onTapped(indexOfBigGrid, indexOfSmallGrid),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            alignment: Alignment.center,
            child: Center(
              child: Text(
                symbol[indexOfSmallGrid],
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
