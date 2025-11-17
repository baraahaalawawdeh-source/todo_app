import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/todo_provider.dart';

class TodoItemTile extends StatelessWidget {
  final TodoItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemTile({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color baseColor = isDark ? Colors.white : const Color(0xFF111827);
    final Color textColor = item.isDone
        ? baseColor.withValues(alpha: 0.55)
        : baseColor;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: SvgPicture.asset(
              item.isDone
                  ? 'assets/icons/checked_box.svg'
                  : 'assets/icons/unchecked_box.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                color: textColor,
                decoration: item.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.close,
              size: 18,
              color: Colors.grey.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
