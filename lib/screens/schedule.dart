// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sistem_akademik/theme/design_system.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildTopBanner(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              children: [
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
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.md,
      ),
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
          Text(
            "Cek kembali riwayat absensimu",
            style: TextStyle(color: AppColors.textOnPrimary, fontSize: 13),
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
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          child: Text(title, style: AppTextStyles.sectionTitle),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: [
              BoxShadow(
                color: AppColors.textSecondary.withOpacity(0.1),
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
                        thickness: 0.5,
                        color: AppColors.background,
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
                Text(item.subject, style: AppTextStyles.itemTitle),
                const SizedBox(height: 4),
                Text(item.lecturer, style: AppTextStyles.itemSubtitle),
                const SizedBox(height: 4),
                Text(
                  "${item.room}   ${item.time}",
                  style: AppTextStyles.itemSubtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.success,
              side: BorderSide(color: AppColors.success, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            ),
            child: const Text("Hadir"),
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
