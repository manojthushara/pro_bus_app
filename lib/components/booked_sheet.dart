import 'package:flutter/material.dart';

class BookSheet extends StatelessWidget {
  final Function()? onTop;
  final String text;

  const BookSheet({super.key, required this.onTop, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(Icons.close,size: 18,color: Colors.white,),
        ),
      ),
    );
  }
}
