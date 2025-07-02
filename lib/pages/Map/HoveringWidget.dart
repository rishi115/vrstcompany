import 'package:flutter/material.dart';

class HoverFloatingWidget extends StatefulWidget {
  @override
  _HoverFloatingWidgetState createState() => _HoverFloatingWidgetState();
}

class _HoverFloatingWidgetState extends State<HoverFloatingWidget> {
  bool _isHovered = false;
  Offset _position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Center(
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onHover: (event) => setState(() => _position = event.position),
          onExit: (_) => setState(() => _isHovered = false),
          child: Stack(
            children: [
              Icon(Icons.info, size: 40),
              if (_isHovered)
                Positioned(
                  left: _position.dx,
                  top: _position.dy,
                  child: Material(
                    elevation: 4,
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(blurRadius: 4)],
                      ),
                      child: Text("This is a floating container"),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
