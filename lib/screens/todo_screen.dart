import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../widgets/todo_item_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  static const double headerHeight = 180;
  static const double addBoxHeight = 66;

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final items = todoProvider.items;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color outerBgColor = isDark
        ? const Color(0xFF161622)
        : const Color(0xFFEAEAEA).withValues(alpha: 0.63);

    final Color outerBorderColor = isDark
        ? const Color(0xFF1F2228)
        : const Color(0xFFE5E7EB);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: outerBgColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: outerBorderColor, width: 1),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: headerHeight,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/header.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'TO DO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<TodoProvider>()
                                            .toggleTheme();
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: SvgPicture.asset(
                                          isDark
                                              ? 'assets/icons/light_icon.svg'
                                              : 'assets/icons/dark_icon.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 27),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 342,
                                  height: 330,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF25273D)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        if (!isDark)
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.05,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: items.isEmpty
                                                ? Center(
                                                    child: Text(
                                                      'No tasks yet.\nAdd your first task!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color
                                                            ?.withValues(
                                                              alpha: 0.7,
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                : ListView.separated(
                                                    itemCount: items.length,
                                                    separatorBuilder: (_, __) =>
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                    itemBuilder:
                                                        (context, index) {
                                                          final item =
                                                              items[index];
                                                          return TodoItemTile(
                                                            item: item,
                                                            onToggle: () =>
                                                                todoProvider
                                                                    .toggleTask(
                                                                      item.id,
                                                                    ),
                                                            onDelete: () =>
                                                                todoProvider
                                                                    .deleteTask(
                                                                      item.id,
                                                                    ),
                                                          );
                                                        },
                                                  ),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${todoProvider.totalCount} Items result',
                                                style: TextStyle(
                                                  color: isDark
                                                      ? const Color(0xFFAEAEAE)
                                                      : const Color(0xFF111827),
                                                  fontSize: 13,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  todoProvider.clearCompleted();
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/clear_icon.svg',
                                                      width: 14,
                                                      height: 14,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Text(
                                                      'Clear Completed',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: SizedBox(
                                  width: 342,
                                  height: 68,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF25273D)
                                          : Colors.white,
                                      borderRadius: BorderRadius.zero,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: isDark
                                              ? const Color(0xFF111827)
                                              : const Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TodoFilterChip(
                                          title: 'All',
                                          width: 78.734375,
                                          isSelected:
                                              todoProvider.filterStatus ==
                                              FilterStatus.all,
                                          onTap: () => todoProvider
                                              .changeFilter(FilterStatus.all),
                                        ),
                                        TodoFilterChip(
                                          title: 'Active',
                                          width: 101.484375,
                                          isSelected:
                                              todoProvider.filterStatus ==
                                              FilterStatus.active,
                                          onTap: () =>
                                              todoProvider.changeFilter(
                                                FilterStatus.active,
                                              ),
                                        ),
                                        TodoFilterChip(
                                          title: 'Completed',
                                          width: 130.578125,
                                          isSelected:
                                              todoProvider.filterStatus ==
                                              FilterStatus.completed,
                                          onTap: () =>
                                              todoProvider.changeFilter(
                                                FilterStatus.completed,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: headerHeight - (addBoxHeight / 2),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        width: 349,
                        height: addBoxHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF25273D)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: isDark
                                ? null
                                : Border.all(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    width: 1,
                                  ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF333333),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Add a new task...',
                                    hintStyle: TextStyle(
                                      color: isDark
                                          ? const Color(0xFFAEAEAE)
                                          : const Color(0xFF9CA3AF),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (value) {
                                    todoProvider.addTask(value);
                                    controller.clear();
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  todoProvider.addTask(controller.text);
                                  controller.clear();
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/add_icon.svg',
                                  width: 14,
                                  height: 14,
                                  colorFilter: isDark
                                      ? const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoFilterChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  const TodoFilterChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const Color selectedBg = Color(0xFF3B82F6);
    const Color unselectedBg = Color(0xFFF3F4F6);

    final Color textColor = isSelected ? Colors.white : const Color(0xFF111827);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 36,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : unselectedBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
