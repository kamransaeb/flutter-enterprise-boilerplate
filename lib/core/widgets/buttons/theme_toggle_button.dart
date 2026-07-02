import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/theme/theme_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(state.currentThemeStatus.icon),
          onPressed: () {
            context.read<ThemeBloc>().add(ThemeEvent.toggleRequested());
          },
        );
      },
    );
  }
}