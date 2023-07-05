import 'package:flutter/material.dart';

class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({super.key});

  @override
  State<InfiniteGridView> createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<String> list = [];
  final _gridScroll = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    list = List.generate(_currentMax, (index) => "Item: ${index + 1}");
    _gridScroll.addListener(() {
      if (_gridScroll.position.pixels == _gridScroll.position.maxScrollExtent) {
        _getData();
      }
    });
    super.initState();
  }

  _getData() {
    Future.delayed(const Duration(seconds: 2), () {
      for (int i = _currentMax; i < _currentMax + 10; i++) {
        list.add("Item: ${i + 1}");
      }
      _currentMax = _currentMax + 10;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            controller: _gridScroll,
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            padding: const EdgeInsets.all(8.0),
            children: List.generate(
              list.length + 1,
              (index) {
                if (index == list.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridTile(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 2.0,
                        )
                      ],
                    ),
                    child: Text(list[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
