import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tic_tac_toe/data/data_base/app_database.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/service_locator.dart';

class _FakeHydratedStorage implements HydratedStorage {
  final Map<String, dynamic> _data = {};

  @override
  dynamic read(String key) => _data[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    HydratedBloc.storage = _FakeHydratedStorage();
    if (!sl.isRegistered<AppDatabase>()) {
      await initDependencies();
    }
  });

  testWidgets('Application smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Application());
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(Application), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 500));
  });
}
