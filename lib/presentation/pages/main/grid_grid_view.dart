import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../domain/entities/grid_items_entity.dart';
import '../../manager/main_bloc/main_bloc.dart';


class GridGridView extends StatelessWidget {
  final GridItemsEntity gridItems;
  final List<Permission> permissionBigGridItems;

  const GridGridView({
    super.key,
    required this.gridItems,
    required this.permissionBigGridItems,
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
        final smallGrid = Grid(
          itemCount: gridItems.smallGridItems[indexOfBigGrid].length,
          crossAxisCount: gridItems.smallGridCrossAxisCount,
          indexOfBigGrid: indexOfBigGrid,
          symbol: gridItems.smallGridItems[indexOfBigGrid],
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

class Grid extends StatelessWidget {
  const Grid({
    super.key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.indexOfBigGrid,
    required this.symbol,
  });

  final int itemCount;
  final int crossAxisCount;
  final int indexOfBigGrid;
  final List<String> symbol;

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
          onTap: () => context.read<MainBloc>().add(
            TappedOnMainEvent(
              indexOfBigGrid: indexOfBigGrid,
              indexOfSmallGrid: indexOfSmallGrid,
            ),
          ),
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
