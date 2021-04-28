import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/cubits/session_cubit.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Account!'),
            const SizedBox(height: 24),
            BlocBuilder<SessionCubit, SessionState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => context.read<SessionCubit>().clearSession(),
                  child: const Text('Sign out'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
