import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnertInsight extends StatefulWidget {
  @override
  _PartnertInsightState createState() => _PartnertInsightState();
}

class _PartnertInsightState extends State<PartnertInsight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Delivery Insights',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Deliveries',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            InsightCard(
              title: 'Total Deliveries',
              value: '325',
              icon: Icons.delivery_dining,
              color: Colors.blue,
            ),
            InsightCard(
              title: 'Successful Deliveries',
              value: '22',
              icon: Icons.check_circle_outline,
              color: Colors.green,
            ),
            InsightCard(
              title: 'Failed Deliveries',
              value: '3',
              icon: Icons.cancel_outlined,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Weekly Insights',
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: InsightChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class InsightCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InsightCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  _InsightCardState createState() => _InsightCardState();
}

class _InsightCardState extends State<InsightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          widget.icon,
          size: 40,
          color: widget.color,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class InsightChart extends StatefulWidget {
  @override
  _InsightChartState createState() => _InsightChartState();
}

class _InsightChartState extends State<InsightChart> {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<DeliveryData, String>> seriesList = [
      charts.Series<DeliveryData, String>(
        id: 'WeeklyDeliveries',
        domainFn: (DeliveryData data, _) => data.day,
        measureFn: (DeliveryData data, _) => data.deliveries,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: [
          DeliveryData('Mon', 20),
          DeliveryData('Tue', 25),
          DeliveryData('Wed', 18),
          DeliveryData('Thu', 22),
          DeliveryData('Fri', 30),
          DeliveryData('Sat', 28),
          DeliveryData('Sun', 24),
        ],
      ),
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
    );
  }
}

class DeliveryData {
  final String day;
  final int deliveries;

  DeliveryData(this.day, this.deliveries);
}
