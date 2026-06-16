import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/locale/locale_bloc.dart';

class LocaleListener extends StatelessWidget {
  const LocaleListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocaleBloc, LocaleState>(
      listenWhen: (previous, current) {
        return previous.locale != current.locale;
      },
      listener: (context, state) {
        if (state.isLoaded) {
          _showLocaleChangedMessage(context, state.displayName);
        } else if (state.hasError) {
          _showErrorMessage(context, state.errorMessage);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showLocaleChangedMessage(BuildContext context, String languageName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.language, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Language changed to $languageName'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message ?? 'Failed to change language'),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}