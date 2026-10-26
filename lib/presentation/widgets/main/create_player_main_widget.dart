import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/theme_extension.dart';
import '../../manager/main_bloc/main_bloc.dart';

class CreatePlayerMainWidget extends StatelessWidget {
  CreatePlayerMainWidget({super.key});

  final TextEditingController _newPlayerController = TextEditingController();

  void _onCreatePlayer(BuildContext context) {
    final name = _newPlayerController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a player name.')));
      return;
    }
    context.read<MainBloc>().add(CreatePlayerMainEvent(name: name));
    _newPlayerController.clear();
    // Убираем фокус с поля ввода.
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Player "$name" created!')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Create a new player',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _newPlayerController,
          textCapitalization: TextCapitalization.words,
          onSubmitted: (_) => _onCreatePlayer(context),
          decoration: InputDecoration(
            hintText: 'New player name',
            prefixIcon: const Icon(Icons.person_add_alt_1_rounded),
            suffixIcon: IconButton(
              tooltip: 'Create player',
              icon: const Icon(Icons.add_circle_outline_rounded),
              onPressed: () => _onCreatePlayer(context),
            ),
            filled: true,
            fillColor: context.colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorScheme.primary, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }
}
