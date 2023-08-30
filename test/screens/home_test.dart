import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/home.dart';

// Ini adalah fungsi untuk membuat tampilan beranda (home screen) dengan widget-widget yang diperlukan.
// Fungsi ini menggunakan ChangeNotifierProvider untuk menyediakan objek Favorites ke dalam widget tree.
Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Home Page Widgets Test', () {
    // TEST 1: Mengetes apakah ListView muncul dengan benar.
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen()); // Memuat widget beranda
      expect(find.byType(ListView),
          findsOneWidget); // Memeriksa apakah ListView muncul satu kali.
    });

    // TEST 2: Mengetes kemampuan scroll dari ListView.
    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen()); // Memuat widget beranda
      expect(find.text('Item 0'),
          findsOneWidget); // Memeriksa apakah 'Item 0' ada di tampilan.
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200), // Mensimulasikan gerakan scroll ke atas
        3000, // Durasi simulasi scroll
      );
      await tester.pumpAndSettle(); // Menunggu sampai animasi selesai
      expect(find.text('Item 0'),
          findsNothing); // Memeriksa apakah 'Item 0' sudah tidak terlihat setelah scroll.
    });

    // TEST 3: Mengetes aksi tombol ikon (IconButton) pada widget.
    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen()); // Memuat widget beranda
      expect(find.byIcon(Icons.favorite),
          findsNothing); // Memeriksa apakah ikon hati penuh tidak terlihat
      await tester.tap(find
          .byIcon(Icons.favorite_border)
          .first); // Mengetuk ikon hati kosong
      await tester.pumpAndSettle(
          const Duration(seconds: 1)); // Menunggu sampai animasi selesai
      expect(find.text('Added to favorites.'),
          findsOneWidget); // Memeriksa pesan "Added to favorites." muncul
      expect(find.byIcon(Icons.favorite),
          findsWidgets); // Memeriksa apakah ikon hati penuh muncul
      await tester
          .tap(find.byIcon(Icons.favorite).first); // Mengetuk ikon hati penuh
      await tester.pumpAndSettle(
          const Duration(seconds: 1)); // Menunggu sampai animasi selesai
      expect(find.text('Removed from favorites.'),
          findsOneWidget); // Memeriksa pesan "Removed from favorites." muncul
      expect(find.byIcon(Icons.favorite),
          findsNothing); // Memeriksa apakah ikon hati penuh tidak terlihat lagi
    });
  });
}
