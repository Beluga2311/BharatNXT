import 'package:flutter/material.dart';
import 'package:bharatnxt/features/listing/domain/entities/pagination_meta.dart';

class PaginationControls extends StatelessWidget {
  final PaginationMeta pagination;
  final ValueChanged<int> onPageSelected;

  const PaginationControls({
    super.key,
    required this.pagination,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavButton(
            icon: Icons.chevron_left_rounded,
            label: 'Prev',
            enabled: pagination.hasPrevious,
            onTap: () => onPageSelected(pagination.currentPage - 1),
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pagination.totalPages, (i) {
                  final page = i + 1;
                  final isActive = page == pagination.currentPage;
                  return GestureDetector(
                    onTap: isActive ? null : () => onPageSelected(page),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isActive ? cs.primary : cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$page',
                        style: tt.labelMedium?.copyWith(
                          color: isActive ? cs.onPrimary : cs.onSurface,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          _NavButton(
            icon: Icons.chevron_right_rounded,
            label: 'Next',
            enabled: pagination.hasNext,
            onTap: () => onPageSelected(pagination.currentPage + 1),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: enabled
            ? cs.primary
            : cs.onSurface.withValues(alpha: 0.38),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
