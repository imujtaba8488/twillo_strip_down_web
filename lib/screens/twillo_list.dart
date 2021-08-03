import 'package:flutter/material.dart';
import 'package:twillo_strip_down/screens/twillo_card_list.dart';

/// Responsible for holding the list of cards.
class TwilloList extends StatefulWidget {
  const TwilloList({Key? key}) : super(key: key);

  @override
  _TwilloListState createState() => _TwilloListState();
}

class _TwilloListState extends State<TwilloList> {
  List<TwilloListCard> _twilloList = [];

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
            itemBuilder: (context, index) {
              return ReorderableDelayedDragStartListener(
                key: ValueKey(index),
                child: _twilloList[index],
                index: index,
              );
            },
            itemCount: _twilloList.length,
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex && newIndex != _twilloList.length - 1) {
                newIndex -= 1;
              }
              final remainingCards = _twilloList.removeAt(oldIndex);
              _twilloList.insert(newIndex, remainingCards);
              setState(() {});
            },
          ),
        ),
        TwilloListCard(
          child: TextButton.icon(
            onPressed: _onAddCard,
            icon: Icon(Icons.add),
            label: Text('Add another list'),
          ),
        ),
      ],
    );
  }

  /// Action to be taken when the card is added to the list.
  void _onAddCard() {
    _twilloList.add(TwilloListCard(child: TwilloCardList()));
    setState(() {});
  }
}

/// Represents a twillo list card.
class TwilloListCard extends StatelessWidget {
  const TwilloListCard({Key? key, @required this.child}) : super(key: key);

  /// The widget to be placed within the List.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(8),
      child: child,
    );
  }
}
