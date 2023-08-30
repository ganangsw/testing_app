import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

late Favorites favoritesList; // Variabel late untuk menyimpan objek Favorites

// Fungsi untuk membuat tampilan halaman favorit dengan widget-widget yang diperlukan.
Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites(); // Membuat objek Favorites
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

// Fungsi untuk menambahkan item pada daftar favorit
void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widget Tests', () {
    // TEST 1: Mengetes apakah ListView muncul dengan benar di halaman favorit.
    testWidgets('Test if ListView shows up', (tester) async {
      await tester
          .pumpWidget(createFavoritesScreen()); // Memuat halaman favorit
      addItems(); // Menambahkan item pada daftar favorit
      await tester.pumpAndSettle(); // Menunggu sampai animasi selesai
      expect(find.byType(ListView),
          findsOneWidget); // Memeriksa apakah ListView muncul satu kali.
    });

    // TEST 2: Mengetes tombol Remove (tutup) pada item favorit.
    testWidgets('Testing Remove Button', (tester) async {
      await tester
          .pumpWidget(createFavoritesScreen()); // Memuat halaman favorit
      addItems(); // Menambahkan item pada daftar favorit
      await tester.pumpAndSettle(); // Menunggu sampai animasi selesai
      var totalItems = tester
          .widgetList(find.byIcon(Icons.close))
          .length; // Menyimpan total item tutup pada awalnya
      await tester.tap(find
          .byIcon(Icons.close)
          .first); // Mengetuk tombol tutup pada item pertama
      await tester.pumpAndSettle(); // Menunggu sampai animasi selesai
      expect(
          tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(
              totalItems)); // Memeriksa apakah jumlah tombol tutup berkurang
      expect(find.text('Removed from favorites.'),
          findsOneWidget); // Memeriksa pesan "Removed from favorites." muncul
    });
  });
}
