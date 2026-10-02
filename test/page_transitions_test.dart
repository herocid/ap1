import 'package:ap1_trainer/core/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

GoRouter _router() => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Text('Start')),
    GoRoute(
      path: '/ziel',
      pageBuilder: (context, state) =>
          fadeSlidePage(state: state, child: const Text('Ziel')),
    ),
  ],
);

Widget _app(GoRouter router, {required bool reduce}) => MaterialApp.router(
  routerConfig: router,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: reduce),
    child: child!,
  ),
);

void main() {
  testWidgets('mit reduzierten Animationen steht die Route sofort', (
    tester,
  ) async {
    final router = _router();
    await tester.pumpWidget(_app(router, reduce: true));
    router.push('/ziel');
    await tester.pump();
    await tester.pump();
    final ziel = find.text('Ziel');
    expect(ziel, findsOneWidget);
    expect(tester.getTopLeft(ziel).dy, 0);
  });

  testWidgets('ohne Reduktion gleitet die Route weich ein', (tester) async {
    final router = _router();
    await tester.pumpWidget(_app(router, reduce: false));
    router.push('/ziel');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.getTopLeft(find.text('Ziel')).dy, greaterThan(0));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('Ziel')).dy, 0);
  });
}
