import '../models/user_model.dart';
import '../models/announcement_model.dart';

class DummyService {
  static UserModel getMockUser() {
    return UserModel(name: "Firza Aurel", avatarUrl: null);
  }

  static List<AnnouncementModel> getMockAnnouncements() {
    return [
      AnnouncementModel(
        title: "Manajemen Produk",
        className: "Kelas C",
        date: "2025-09-09",
        content:
            "Yth. Mahasiswa, Mohon maaf, hari ini (Rabu, 10/9) kelas manajemen produk ditiadakan karena saya ada tugas ke luar kota. Terima kasih.",
      ),
      AnnouncementModel(
        title: "Pemrograman Mobile",
        className: "Kelas A",
        date: "2025-09-10",
        content:
            "Tugas praktikum ke-5 sudah diunggah di LMS. Batas pengumpulan hari Minggu pukul 23.59.",
      ),
    ];
  }
}
