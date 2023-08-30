import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/models/favorites.dart';

void main() {
  // Fungsi utama untuk menjalankan pengujian

  group('Pengujian App Provider', () {
    // Pengelompokan pengujian terkait dengan "App Provider"

    var favorites = Favorites();  // Buat objek Favorites

    test('Penambahan item baru', () {
      // Pengujian: Menambahkan dan menghapus item baru

      var number = 35;  // Angka yang akan ditambahkan dan dihapus
      favorites.add(number);  // Tambahkan angka ke daftar favorit
      expect(favorites.items.contains(number), isTrue);  // Periksa apakah angka ada di favorit
      favorites.remove(number);  // Hapus angka dari daftar favorit
      expect(favorites.items.contains(number), isFalse);  // Periksa apakah angka dihapus dari favorit
    });
  });
}

