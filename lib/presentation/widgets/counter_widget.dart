import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int count;
  final Function(int i) onChange;
  const CounterWidget({super.key, this.count = 1, required this.onChange});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  void increment() {
    widget.onChange(widget.count + 1);
  }

  void decrement() {
    widget.onChange(widget.count - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, decrement),
        _buildCountDisplay(),
        _buildButton(Icons.add, increment),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18),
        ),
      ),
    );
  }

  Widget _buildCountDisplay() {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${widget.count}',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
