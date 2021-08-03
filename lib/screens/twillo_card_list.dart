import 'package:flutter/material.dart';

class TwilloCardList extends StatefulWidget {
  const TwilloCardList({Key? key}) : super(key: key);

  @override
  _TwilloCardListState createState() => _TwilloCardListState();
}

class _TwilloCardListState extends State<TwilloCardList> {
  List<TwilloCard> _cards = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _cards.length > 0
              ? Expanded(
                  child: ReorderableListView.builder(
                    buildDefaultDragHandles: false,
                    itemBuilder: (context, index) {
                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(index),
                        child: _cards[index],
                        index: index,
                      );
                    },
                    itemCount: _cards.length,
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final remainingCards = _cards.removeAt(oldIndex);
                      _cards.insert(newIndex, remainingCards);
                    },
                  ),
                )
              : Container(),
          if (_cards.length == 0)
            TextButton.icon(
              onPressed: () => onAddCard(0),
              icon: Icon(Icons.add),
              label: Text('Add card to list'),
            )
        ],
      ),
    );
  }

  /// Action to be taken when a card is to be added to the Card list.
  void onAddCard(int index) {
    _cards.add(
      TwilloCard(
        onAddCard: () => onAddCard(index),
        onDeleteCard: _onDeleteCard,
        index: index,
      ),
    );
    setState(() {});
  }

  /// Action to be taken when a card is to be deleted.
  void _onDeleteCard(int index) {
    _cards.removeAt(index);
    setState(() {});
  }
}

/// Represents the card to be placed within a [TwilloCardList].
class TwilloCard extends StatelessWidget {
  const TwilloCard({
    Key? key,
    @required this.onAddCard,
    @required this.onDeleteCard,
    @required this.index,
  }) : super(key: key);

  final VoidCallback? onAddCard;
  final ValueSetter<int>? onDeleteCard;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 300,
      child: Card(
        elevation: 3,
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Doing'),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outlined),
                  onPressed: () => onDeleteCard!(index!),
                )
              ],
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Example Task'
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Example Description'
                ),
                maxLines: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  'Add a card',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                onPressed: onAddCard,
              ),
            )
          ],
        ),
      ),
    );
  }
}
