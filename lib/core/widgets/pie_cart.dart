// lib/presentation/widgets/charts/donation_pie_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';

class DonationPieChart extends StatefulWidget {

  const DonationPieChart({
    required this.items, super.key,
    this.size = 200,
  });
  final List<PieChartItem> items;
  final double size;

  @override
  State<DonationPieChart> createState() => _DonationPieChartState();
}

class _DonationPieChartState extends State<DonationPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final total = widget.items.fold<double>(0, (sum, i) => sum + i.value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: widget.size,
          width: widget.size,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 50, // 0 si quieres torta sólida, >0 para donut
              sections: _buildSections(total),
            ),
          ),
        ),
        Expanded(child: _buildLegend(total)),
      ],
    );
  }

  List<PieChartSectionData> _buildSections(double total) {
    return List.generate(widget.items.length, (i) {
      final item = widget.items[i];
      final isTouched = i == _touchedIndex;

      return PieChartSectionData(
          color: item.color,
          value: item.value,
          radius: isTouched ? 40 : 30,
          showTitle: false,);
    });
  }

  Widget _buildLegend(double total) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${item.label}: ${((item.value / total) * 100).toStringAsFixed(0)}%',
                        softWrap: true,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),)
          .toList(),
    );
  }
}

class PieChartItem {

  PieChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final double value;
  final Color color;
}
