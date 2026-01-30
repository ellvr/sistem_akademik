// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sistem_akademik/theme/design_system.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.white,
      //   elevation: 2,
      //   shadowColor: Colors.black.withOpacity(0.5),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   leading: canPop
      //       ? IconButton(
      //           icon: const Icon(Icons.arrow_back, color: Colors.black),
      //           onPressed: () => Navigator.pop(context),
      //         )
      //       : null,
      //   title: const Text(
      //     "Riwayat Presensi",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 18,
      //     ),
      //   ),
      // ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        children: [
          SizedBox(height: 10),
          _buildTopBanner(),
          _buildDateGroup(
            title: "Senin, 15 September 2025",
            items: [
              ScheduleItemData(
                subject: "Sistem Enterprise - A",
                lecturer: "Almira Syawli, S.Kom., M.Kom.",
                room: "F3.10",
                time: "12.30 : 15.00",
              ),
              ScheduleItemData(
                subject: "Sistem Enterprise - A",
                lecturer: "Almira Syawli, S.Kom., M.Kom.",
                room: "F3.10",
                time: "10.30 : 12.10",
              ),
              ScheduleItemData(
                subject: "Sistem Enterprise - A",
                lecturer: "Almira Syawli, S.Kom., M.Kom.",
                room: "F3.10",
                time: "7.00 : 8.40",
              ),
            ],
          ),
          _buildDateGroup(
            title: "Jumat, 12 September 2025",
            items: [
              ScheduleItemData(
                subject: "Sistem Enterprise - A",
                lecturer: "Almira Syawli, S.Kom., M.Kom.",
                room: "F3.10",
                time: "12.30 : 15.00",
              ),
              ScheduleItemData(
                subject: "Sistem Enterprise - A",
                lecturer: "Almira Syawli, S.Kom., M.Kom.",
                room: "F3.10",
                time: "10.30 : 12.10",
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            color: AppColors.textOnPrimary,
          ),
          const SizedBox(width: AppSpacing.sm),
          const Text(
            "Cek kembali riwayat presensimu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateGroup({
    required String title,
    required List<ScheduleItemData> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
          child: Text(
            title,
            style: AppTextStyles.sectionTitle.copyWith(color: AppColors.accent),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  _buildScheduleItem(item: item),
                  if (index < items.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Divider(
                        thickness: 0.8,
                        color: Colors.grey.shade100,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem({required ScheduleItemData item}) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subject,
                  style: AppTextStyles.itemTitle.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  item.lecturer,
                  style: AppTextStyles.itemSubtitle.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${item.room}   ${item.time}",
                  style: AppTextStyles.itemSubtitle.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Hadir",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleItemData {
  final String subject;
  final String lecturer;
  final String room;
  final String time;

  ScheduleItemData({
    required this.subject,
    required this.lecturer,
    required this.room,
    required this.time,
  });
}
