import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:flutter_test/flutter_test.dart';

/// Der einmalige Reset nach der Testphase: alte Daten werden gelöscht,
/// aktuelle bleiben, neue Nutzer merken nichts.
void main() {
  late HiveLocalStore store;
  setUp(() async => store = await HiveLocalStore.open(inMemory: true));
  tearDown(() => store.close());

  test('Daten aus älterem Stand werden komplett gelöscht', () async {
    final json =
        UserProfile.initial()
            .copyWith(displayName: 'Mia', onboarded: true, tutorialSeen: true)
            .toJson()
          ..remove('intro_version');
    await store.writeProfile(UserProfile.fromJson(json));
    await store.writeCardState(const CardState(cardId: 'a', box: 3));

    await resetOutdatedData(store);

    expect(store.readProfile(), isNull);
    expect(store.readDeck().cards, isEmpty);
  });

  test('aktueller Stand bleibt unangetastet', () async {
    await store.writeProfile(
      UserProfile.initial().copyWith(onboarded: true, tutorialSeen: true),
    );
    await store.writeCardState(const CardState(cardId: 'a', box: 3));

    await resetOutdatedData(store);

    expect(store.readProfile()?.onboarded, isTrue);
    expect(store.readDeck().cards, isNotEmpty);
  });

  test('ohne Profil passiert nichts', () async {
    await resetOutdatedData(store);
    expect(store.readProfile(), isNull);
  });
}
