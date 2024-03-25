import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerPayout extends StatefulWidget {
  @override
  _PartnerPayoutState createState() => _PartnerPayoutState();
}

class _PartnerPayoutState extends State<PartnerPayout> {
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PayoutCard(
              title: 'Total Earnings',
              value: '\₹ 550.00',
              icon: Icons.account_balance_wallet,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            PayoutCard(
              title: 'Pending',
              value: '\₹ 120.00',
              icon: Icons.pending,
              color: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Payout History',
                style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: PayoutHistoryList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PayoutCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const PayoutCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  _PayoutCardState createState() => _PayoutCardState();
}

class _PayoutCardState extends State<PayoutCard> {
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
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PayoutHistoryList extends StatefulWidget {
  @override
  _PayoutHistoryListState createState() => _PayoutHistoryListState();
}

class _PayoutHistoryListState extends State<PayoutHistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Assuming there are 5 payout transactions
      itemBuilder: (context, index) {
        // Replace this with actual payout transaction data
        final transaction = PayoutTransaction(
          date: 'Jan 20, 2023',
          amount: '\$50.00',
          status: 'Completed',
        );

        return PayoutHistoryItem(transaction: transaction);
      },
    );
  }
}

class PayoutTransaction {
  final String date;
  final String amount;
  final String status;

  PayoutTransaction({
    required this.date,
    required this.amount,
    required this.status,
  });
}

class PayoutHistoryItem extends StatefulWidget {
  final PayoutTransaction transaction;

  const PayoutHistoryItem({required this.transaction});

  @override
  _PayoutHistoryItemState createState() => _PayoutHistoryItemState();
}

class _PayoutHistoryItemState extends State<PayoutHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          'Date: ${widget.transaction.date}',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: ${widget.transaction.amount}',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            Text(
              'Status: ${widget.transaction.status}',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
