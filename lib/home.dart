import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 100;
  static const int _itemCount = 100;

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ClickableListWheelScrollView(
          scrollController: _scrollController,
          itemHeight: _itemHeight,
          itemCount: _itemCount,
          onItemTapCallback: (index) {
            debugPrint("onItemTapCallback index: $index");
          },
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: _itemHeight,
            physics: const FixedExtentScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            perspective: 0.002,
            onSelectedItemChanged: (index) {
              debugPrint("onSelectedItemChanged index: $index");
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) => _child(index),
              childCount: _itemCount,
            ),
          ),
        ),
      ),
    );
  }

  Widget _child(int index) {
    return SizedBox(
      height: _itemHeight,
      child: ListTile(
        leading: Icon(
            IconData(int.parse("0xe${index + 200}"),
                fontFamily: 'MaterialIcons'),
            size: 50),
        title: const Text('Heart Shaker'),
        subtitle: const Text('Description here'),
      ),
    );
  }
}
