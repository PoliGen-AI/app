import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poligen_app/models/user_model.dart';
import 'package:poligen_app/widgets/profile_modal.dart';

void main() {
  testWidgets('Profile modal displays user information correctly', (
    WidgetTester tester,
  ) async {
    // Create mock user data
    final user = User.mock();

    // Build the profile modal
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ProfileModal(user: user, onUserUpdated: (updatedUser) {}),
                );
              },
              child: const Text('Show Profile'),
            ),
          ),
        ),
      ),
    );

    // Tap the button to show the modal
    await tester.tap(find.text('Show Profile'));
    await tester.pumpAndSettle();

    // Verify the modal is displayed
    expect(find.text('Perfil'), findsOneWidget);

    // Verify user information is displayed
    expect(find.text(user.name), findsOneWidget);
    expect(find.text(user.email), findsOneWidget);

    // Verify user ID is displayed
    expect(find.textContaining('ID do Usuário'), findsOneWidget);
    expect(find.text(user.id), findsOneWidget);

    // Verify bio is displayed
    expect(find.textContaining('Designer apaixonado'), findsOneWidget);

    // Verify statistics are displayed
    expect(find.text('Imagens Geradas'), findsOneWidget);
    expect(find.text('24'), findsOneWidget);

    // Verify join date is displayed
    expect(find.text('Membro Desde'), findsOneWidget);
    expect(find.textContaining('15 de março'), findsOneWidget);

    // Verify additional info section
    expect(find.text('Informações Adicionais'), findsOneWidget);
    expect(find.text('Conta Verificada'), findsOneWidget);

    // Verify buttons are present
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.text('Fechar'), findsOneWidget);
  });

  testWidgets('Profile modal close button works', (WidgetTester tester) async {
    final user = User.mock();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ProfileModal(user: user, onUserUpdated: (updatedUser) {}),
                );
              },
              child: const Text('Show Profile'),
            ),
          ),
        ),
      ),
    );

    // Show modal
    await tester.tap(find.text('Show Profile'));
    await tester.pumpAndSettle();

    // Verify modal is shown
    expect(find.text('Perfil'), findsOneWidget);

    // Tap close button
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify modal is closed
    expect(find.text('Perfil'), findsNothing);
  });

  testWidgets('Profile modal edit mode works', (WidgetTester tester) async {
    final user = User.mock();

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 1200,
          height: 800,
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ProfileModal(
                      user: user,
                      onUserUpdated: (updatedUser) {},
                    ),
                  );
                },
                child: const Text('Show Profile'),
              ),
            ),
          ),
        ),
      ),
    );

    // Show modal
    await tester.tap(find.text('Show Profile'));
    await tester.pumpAndSettle();

    // Switch to edit mode
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verify we're in edit mode
    expect(find.text('Editar Perfil'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Biografia'), findsOneWidget);
    expect(find.text('Salvar'), findsOneWidget);
    expect(find.text('Cancelar'), findsOneWidget);
  });

  test('User model creates mock user correctly', () {
    final user = User.mock();

    expect(user.id, 'user-001');
    expect(user.name, 'João Silva');
    expect(user.email, 'joao.silva@email.com');
    expect(user.imagesGenerated, 24);
    expect(user.bio, isNotNull);
    expect(user.bio!.isNotEmpty, true);
    expect(user.joinDate, isNotNull);
    expect(user.joinDate!.year, 2024);
    expect(user.joinDate!.month, 3);
    expect(user.joinDate!.day, 15);
  });

  test('User copyWith works correctly', () {
    final user = User.mock();
    final updatedUser = user.copyWith(name: 'Maria Silva', imagesGenerated: 30);

    expect(updatedUser.name, 'Maria Silva');
    expect(updatedUser.imagesGenerated, 30);
    expect(updatedUser.email, user.email); // Should remain the same
    expect(updatedUser.id, user.id); // Should remain the same
  });
}
