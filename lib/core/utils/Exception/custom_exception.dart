import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class CustomException implements Exception {
  /// A message describing the format error.
  final String message;

  const CustomException({this.message = ""});
}

class CatchErrorMessage {
  final Object error;

  CatchErrorMessage({required this.error});

  String getWriteMessage() {
    String? errorMessage;

    switch (error) {
      case PostgrestException error:
        // Try to parse as JSON first, if that fails use the message directly
        try {
          final decoded = jsonDecode(error.message);
          errorMessage = decoded is Map
              ? decoded['message']
              : decoded.toString();
        } catch (e) {
          // If JSON parsing fails, use the message directly or details
          // PostgrestException.details often contains the actual database error message
          if (error.message.isNotEmpty) {
            errorMessage = error.message;
          } else if (error.details != null && error.details is String) {
            errorMessage = error.details as String;
          } else {
            errorMessage = error.toString();
          }
        }
        break;
      case AuthApiException error:
        errorMessage = error.message;
        break;
      case StorageException error:
        errorMessage = error.message;
        break;
      case CustomException error:
        errorMessage = error.message;
        break;
      case Exception error:
        errorMessage = error.toString();
        break;
      default:
        errorMessage = error.toString();
        break;
    }

    switch (errorMessage) {
      case "Cannot coerce the result to a single JSON object":
        errorMessage = "Empty data update";
        break;
      default:
        // Use errorMessage instead of error.toString()
        break;
    }
    return errorMessage ?? error.toString();
  }
}
