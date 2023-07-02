import 'package:flutter/material.dart';

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  List<String> list = [];
  final _listScroll = ScrollController();
  int _currentMax = 20;

  @override
  void initState() {
    list = List.generate(20, (index) => "Item: ${index + 1}");
    _listScroll.addListener(() {
      if (_listScroll.position.pixels == _listScroll.position.maxScrollExtent) {
        _getData();
      }
    });
    super.initState();
  }

  _getData() {
    Future.delayed(const Duration(seconds: 2), () {
      for (int i = _currentMax; i < _currentMax + 20; i++) {
        list.add("Item: ${i + 1}");
      }
      _currentMax = _currentMax + 20;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _listScroll,
      itemCount: list.length + 1,
      padding: const EdgeInsets.all(8.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        if (index == list.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          height: 40.0,
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
        );
      },
    );
  }
}
