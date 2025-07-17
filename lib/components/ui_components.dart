import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class UIConstants {
  static const double defaultPadding = 16.0;
  static const double defaultSpacing = 8.0;
  static const double cardBorderRadius = 12.0;
  static const double cardElevation = 2.0;
}

class UIComponents {
  static AppBar appBar(BuildContext context, String title) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green[900],
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),

      ),
      elevation: 2,
      actions: [
        TextButton(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).go(AppRoutes.profile);
          },
        ),
      ],
    );
  }

  static Widget card(
    BuildContext context,
    String title,
    Widget content, {
    String? description,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    double? elevation,
    double? borderRadius,
    List<BoxShadow>? shadow,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          borderRadius ?? UIConstants.cardBorderRadius,
        ),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
        boxShadow:
            shadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: elevation ?? UIConstants.cardElevation,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(UIConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: UIConstants.defaultSpacing / 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
            SizedBox(height: UIConstants.defaultSpacing),
            content,
          ],
        ),
      ),
    );
  }

  static Widget primaryButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(

          label,
          style: Theme.of(

            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  //secondary
  static Widget secondaryButton(
      BuildContext context,
      String label,
      VoidCallback onPressed,
      ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[200],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(

          label,
          style: Theme.of(

            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
