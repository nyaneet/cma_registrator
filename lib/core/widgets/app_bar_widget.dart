import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String? _title;
  final double? _height;
  final List<Widget> _leftWidgets;
  final List<Widget> _rightWidgets;
  ///
  const AppBarWidget({
    super.key, 
    List<Widget> leftWidgets = const [], 
    List<Widget> rightWidgets = const [], 
    double? height, 
    String? title,
  }) : 
    _title = title, 
    _height = height, 
    _rightWidgets = rightWidgets, 
    _leftWidgets = leftWidgets;
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: _height,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (Navigator.of(context).canPop())
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: const Icon(Icons.arrow_back),
                  ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _leftWidgets,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _title ?? '',
            style: theme.textTheme.headlineSmall,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _rightWidgets,
            ),
          ),
        ],
      ),
    );
  }
}