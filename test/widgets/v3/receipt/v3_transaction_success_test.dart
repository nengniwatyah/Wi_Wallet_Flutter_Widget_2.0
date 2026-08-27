import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/widgets/v3/receipt/v3_transaction_success.dart';

void main() {
  Widget buildSubject({
    Brightness brightness = Brightness.light,
    double textScale = 1,
  }) {
    return MaterialApp(
      theme: ThemeData(brightness: brightness, useMaterial3: true),
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: V3TransactionSuccess(
            confirmationTitle: 'Transaction Confirmed',
            transactionType: 'Transfer',
            amountLabel: 'Amount',
            amount: '5,000.00 THB',
            feeLabel: 'Fees',
            fee: '5.00 THB',
            senderLabel: 'From',
            senderName: 'Sender',
            senderAccount: 'x-1234',
            merchantLabel: 'To',
            merchantName: 'Recipient',
            dateTimeLabel: 'Date & Time:',
            dateTime: '2025-10-06 12:00:53',
            transactionIdLabel: 'Transaction ID:',
            transactionId: 'WP123',
            merchantRefIdLabel: 'Merchant Ref ID:',
            merchantRefId: 'M123',
            billerIdLabel: 'Biller ID:',
            billerId: 'B123',
            ref1Label: 'Ref 1:',
            ref1: 'R1',
            footerNoteOne: 'Keep this receipt.',
            footerNoteTwo: 'Contact support if needed.',
          ),
        ),
      ),
    );
  }

  testWidgets('renders transaction summary in light and dark themes', (
    tester,
  ) async {
    for (final brightness in Brightness.values) {
      await tester.pumpWidget(buildSubject(brightness: brightness));
      expect(find.text('Transaction Confirmed'), findsOneWidget);
      expect(find.text('5,000.00 THB'), findsOneWidget);
      expect(find.text('WP123'), findsOneWidget);
    }
  });

  testWidgets('wraps content at increased text scale', (tester) async {
    await tester.pumpWidget(buildSubject(textScale: 2));
    expect(find.text('Transaction Confirmed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('exposes a semantic container', (tester) async {
    await tester.pumpWidget(buildSubject());
    final semantics = tester.getSemantics(find.byType(V3TransactionSuccess));
    expect(semantics.label, contains('Transaction Confirmed'));
  });
}
