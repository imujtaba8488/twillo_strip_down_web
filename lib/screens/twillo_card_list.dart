import 'package:flutter/material.dart';

import 'twillo_list.dart';

/// Responsible for holding the list of cards.
class TwilloList extends StatefulWidget {
  const TwilloList({Key? key}) : super(key: key);

  @override
  _TwilloListState createState() => _TwilloListState();
}

class _TwilloListState extends State<TwilloList> {
  // Maintains the list of twillo list cards.
  final List<TwilloListCard> _twilloList = [];

  // Maintains the current index.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            buildDefaultDragHandles: true,
            itemBuilder: (context, index) => _twilloList[index],
            itemCount: _twilloList.length,
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex) newIndex -= 1;

              final remainingCards = _twilloList.removeAt(oldIndex);
              _twilloList.insert(newIndex, remainingCards);
            },
          ),
        ),
        TwilloListCard(
          index: -1,
          child: TextButton.icon(
            onPressed: _onAddListCard,
            icon: Icon(Icons.add),
            label: Text('Add another list'),
          ),
        ),
      ],
    );
  }

  /// Action to be taken when the card is added to the list.
  void _onAddListCard() {
    setState(() {
      _twilloList.add(
        TwilloListCard(
          key: ValueKey(_currentIndex),
          index: _currentIndex,
          child: TwilloCardList(
            key: ValueKey(_currentIndex),
          ),
        ),
      );
    });
    _currentIndex++;
  }
}

/// Represents a twillo list card.
class TwilloListCard extends StatelessWidget {
  const TwilloListCard({
    Key? key,
    @required this.child,
    @required this.index,
  }) : super(key: key);

  /// The widget to be placed within the List.
  final Widget? child;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ReorderableDelayedDragStartListener(
      index: index!,
      child: Container(
        width: 350,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
