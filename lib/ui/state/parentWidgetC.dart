import 'package:flutter/material.dart';

class ParentWidgetC extends StatefulWidget {
  @override
  createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool value) {
    setState(() {
      _active = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  @override
  createState() => TapboxCState();
}

class TapboxCState extends State<TapboxC> {
  bool _heightlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _heightlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _heightlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _heightlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _heightlight
                ? Border.all(color: Colors.teal[700], width: 10)
                : null),
      ),
    );
  }
}
