import 'package:flutter/material.dart';
import 'package:sistem_akademik/theme/design_system.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  const EditProfileScreen({super.key, required this.currentName});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color primaryButtonColor = Color(0xFF0482A8);
  static const Color textFieldBorderColor = Color(0xFFD9D9D9);

  late TextEditingController _namaController;
  final TextEditingController _tempatLahirController = TextEditingController(
    text: 'Malang, Jawa Timur',
  );
  final TextEditingController _alamatController = TextEditingController(
    text: 'Jl. Terusan Cikampek, No 110',
  );
  final TextEditingController _noHpController = TextEditingController(
    text: '081234567890',
  );

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tempatLahirController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  void _handleSave() {
    Navigator.of(context).pop({
      'nama': _namaController.text,
      'tempatLahir': _tempatLahirController.text,
      'alamat': _alamatController.text,
      'noHp': _noHpController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perubahan profil berhasil disimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryButtonColor,
        elevation: 0,
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildEditField(
                label: 'Nama Lengkap',
                controller: _namaController,
              ),
              _buildEditField(
                label: 'Tempat Lahir',
                controller: _tempatLahirController,
              ),
              _buildEditField(label: 'Alamat', controller: _alamatController),
              _buildEditField(
                label: 'No. HP',
                controller: _noHpController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryButtonColor,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: textFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: textFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: primaryButtonColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
