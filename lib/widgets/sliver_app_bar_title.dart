import 'package:flutter/material.dart';

class SliverAppBarTitle extends StatefulWidget {
  final Widget child;

  SliverAppBarTitle({required this.child});

  @override
  State<SliverAppBarTitle> createState() => _SliverAppBarTitleState();
}

class _SliverAppBarTitleState extends State<SliverAppBarTitle> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible ?? false,
      child: widget.child,
    );
  }
}
