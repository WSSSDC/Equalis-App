import 'package:flutter/material.dart';

class RoundedRectangle extends StatefulWidget {
  const RoundedRectangle({required this.child, this.color = Colors.white, this.padding = EdgeInsets.zero, this.borderWidth = 0.0, this.onTap, Key? key}) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double borderWidth;
  final Function? onTap;

  @override
  State<RoundedRectangle> createState() => _RoundedRectangleState();
}

class _RoundedRectangleState extends State<RoundedRectangle> {

  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      // duration: const Duration(milliseconds: 5),
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTapDown: (_) {
            if (widget.onTap != null) {
              setState(() {
                opacity = 0.5;
              });
            }
          },

          onTapUp: (_) async {
            if (widget.onTap != null) {
              widget.onTap!();
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  opacity = 1.0;
                });
              });
            }
          },
          child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: widget.borderWidth < 1 ? BorderSide.none : BorderSide(
                  color: Colors.black,
                  width: widget.borderWidth,
                ),
              ),
              child: Container(
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 40,
              spreadRadius: 5
            ),
          ],
        ),
      ),
    );
  }
}