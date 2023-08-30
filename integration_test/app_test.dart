import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      // Loop untuk menambahkan item ke favorit dan memeriksa pesan yang muncul
      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon))); // Mengetuk ikon
        await tester.pumpAndSettle(
            const Duration(seconds: 1)); // Menunggu hingga animasi selesai

        expect(find.text('Added to favorites.'),
            findsOneWidget); // Memeriksa pesan "Added to favorites." muncul
      }

      // Mengetuk tautan 'Favorites' untuk masuk ke halaman favorit
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle(); // Menunggu hingga animasi selesai

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      // Loop untuk menghapus item dari favorit dan memeriksa pesan yang muncul
      for (final iconKey in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(iconKey))); // Mengetuk ikon hapus
        await tester.pumpAndSettle(
            const Duration(seconds: 1)); // Menunggu hingga animasi selesai

        expect(find.text('Removed from favorites.'),
            findsOneWidget); // Memeriksa pesan "Removed from favorites." muncul
      }
    });
  });
}
