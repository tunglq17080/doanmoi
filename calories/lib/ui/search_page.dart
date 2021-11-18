import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: use_key_in_widget_constructors
class RecipeSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecipeSearchState();
}

class RecipeSearchState extends State<RecipeSearch> {
  bool _isEditting = false;

  List<Widget> _buildActions(bool isEditting) {
    if (isEditting) {
      return [
        Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
          color: Colors.grey[100],
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => {},
          ),
        ),
      ];
    }
    return [
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () => _onFilterPress(context),
      ),
      IconButton(
        icon: const Icon(Icons.mic_none),
        onPressed: () => {},
      ),
    ];
  }

  Widget _buildLeading(bool isEditting) {
    if (isEditting) {
      return Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
        color: Colors.grey[100],
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _cancelEditting,
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _onSearchBarTapped() {
    setState(() {
      _isEditting = true;
    });
  }

  void _cancelEditting() {
    setState(() {
      _isEditting = false;
    });
  }

  void _onFilterPress(BuildContext pcontext) {
    showDialog(
        context: pcontext,
        builder: (BuildContext context) {
          return _filterDialog();
        });
  }

  Widget _filterDialog() {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      titleTextStyle: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 4,
          children: List<Widget>.generate(
            50,
            (int index) {
              return ChoiceChip(
                pressElevation: 0.0,
                selectedColor: Colors.blue,
                backgroundColor: Colors.grey[100],
                label: Text("item $index"),
                selected: false,
              );
            },
          ).toList(),
        ),
      ),
      title: const Text('Chọn các bộ lọc'),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text('Đóng'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

  Widget _layoutStack() => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            forceElevated: true,
            centerTitle: true,
            titleSpacing: 0.0,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onTap: _onSearchBarTapped,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Nhập tên công thức bạn cần tìm',
                ),
              ),
            ),
            leading: _buildLeading(_isEditting),
            actions: _buildActions(_isEditting),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 75,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Image(
                          image:
                              NetworkImage('https://placeimg.com/640/480/any'),
                          fit: BoxFit.fill,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text('Title'),
                            subtitle: Text('Subtitle'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 200,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutStack(),
    );
  }
}
