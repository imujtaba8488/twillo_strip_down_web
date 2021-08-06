import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twillo_strip_down/business/models/task.dart';
import 'package:twillo_strip_down/services/session_notifier.dart';

class TwilloCardList extends StatefulWidget {
  const TwilloCardList({Key? key}) : super(key: key);

  @override
  _TwilloCardListState createState() => _TwilloCardListState();
}

class _TwilloCardListState extends State<TwilloCardList> {
  List<TwilloCard> _cards = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final provider = watch(taskProvider.notifier);
      List<Task> taskList = provider.taskList;

      _cards = List.generate(
        taskList.length,
        (index) {
          _currentIndex++;
          return TwilloCard(
            onAddCard: _addCard,
            index: index,
            key: ValueKey(_currentIndex),
          );
        },
      );

      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _cards.length > 0
                ? Expanded(
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      itemBuilder: (context, index) => _cards[index],
                      itemCount: _cards.length,
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) newIndex -= 1;

                        final oldCard = _cards.removeAt(oldIndex);
                        _cards.insert(newIndex, oldCard);
                      },
                    ),
                  )
                : Container(),
            if (_cards.length == 0)
              TextButton.icon(
                onPressed: _addCard,
                icon: Icon(Icons.add),
                label: Text('Add card to list'),
              )
          ],
        ),
      );
    });
  }

  void _addCard() {
    context.read(taskProvider).add(
          Task(title: 'testing', description: 'testing'),
        );

    _cards.add(
      TwilloCard(
        onAddCard: _addCard,
        index: _currentIndex,
        key: ValueKey(_currentIndex),
      ),
    );
    setState(() {});
  }
}

/// Represents the card to be placed within a [TwilloCardList].
class TwilloCard extends StatelessWidget {
  const TwilloCard({
    Key? key,
    @required this.onAddCard,
    @required this.index,
    this.onDeleteCard,
    this.title = '',
    this.description = '',
  }) : super(key: key);

  /// Callback to add a card.
  final VoidCallback? onAddCard;

  /// The current index of the card.
  final int? index;

  /// Callback to delete a card.
  final ValueSetter<int>? onDeleteCard;

  final String title;

  final String description;

  @override
  Widget build(BuildContext context) {
    return ReorderableDelayedDragStartListener(
      index: index!,
      child: Container(
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
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: title.isEmpty ? 'Sample Text' : title,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: description.isEmpty ? 'description' : description,
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
      ),
    );
  }
}
