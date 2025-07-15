import 'package:clisence/utils/app_theme.dart';
import 'package:flutter/material.dart';

/// A generic class to handle API responses
class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool success;

  ApiResponse.success(this.data)
      : success = true,
        error = null;

  ApiResponse.error(this.error)
      : success = false,
        data = null;

  bool get hasError => error != null;
  bool get hasData => data != null;

  /// Helper method to show a snackbar with the error message
  void showErrorSnackbar(BuildContext context, {String? customMessage}) {
    if (error != null || customMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(customMessage ?? error!),
          backgroundColor: AppTheme.errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          ),
        ),
      );
    }
  }

  /// Helper method to show a success snackbar
  static void showSuccessSnackbar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
      ),
    );
  }
}

/// Extension on Future to handle API responses
extension FutureApiResponseExtension<T> on Future<ApiResponse<T>> {
  /// Handle the API response and show appropriate feedback to the user
  Future<T?> handleResponse(
    BuildContext context, {
    String? successMessage,
    String? errorMessage,
    bool showSuccessSnackbar = false,
    bool showErrorSnackbar = true,
    Function(T data)? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      final response = await this;
      
      if (response.hasError) {
        if (showErrorSnackbar) {
          response.showErrorSnackbar(
            context,
            customMessage: errorMessage,
          );
        }
        onError?.call(response.error!);
        return null;
      } else if (response.hasData) {
        if (showSuccessSnackbar && successMessage != null) {
          ApiResponse.showSuccessSnackbar(context, message: successMessage);
        }
        onSuccess?.call(response.data!);
        return response.data;
      }
      return null;
    } catch (e) {
      if (showErrorSnackbar) {
        ApiResponse<dynamic>.error(errorMessage ?? 'An unexpected error occurred')
            .showErrorSnackbar(
          context,
          customMessage: errorMessage ?? 'An unexpected error occurred',
        );
      }
      onError?.call(e.toString());
      return null;
    }
  }
}

/// Extension on BuildContext to show loading dialogs
extension LoadingDialogExtension on BuildContext {
  /// Show a loading dialog
  void showLoadingDialog({String message = 'Loading...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Hide the current loading dialog
  void hideLoadingDialog() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
