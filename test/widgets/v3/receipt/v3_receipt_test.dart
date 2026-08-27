import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/widgets/v3/receipt/v3_receipt.dart';

void main() {
  Widget buildSubject({Brightness brightness = Brightness.light}) {
    return MaterialApp(
      theme: ThemeData(brightness: brightness, useMaterial3: true),
      home: Scaffold(
        body: SingleChildScrollView(
          child: V3Receipt(
            amount: '5,000.00 THB',
            fee: 'Fees 5.00 THB',
            senderName: 'Sender',
            senderAccount: 'x-1234',
            merchantName: 'Recipient',
            merchantAccount: 'x-7890',
            dateTime: '2025-10-06 12:00:53',
            transactionId: 'WP123',
            merchantRefId: 'M123',
            billerId: 'B123',
            ref1: 'R1',
            footerNoteOne: 'Keep this receipt.',
            footerNoteTwo: 'Contact support if needed.',
          ),
        ),
      ),
    );
  }

  testWidgets('renders receipt content in Light and Dark themes', (
    tester,
  ) async {
    for (final brightness in Brightness.values) {
      await tester.pumpWidget(buildSubject(brightness: brightness));
      expect(find.text('Payment'), findsOneWidget);
      expect(find.text('5,000.00 THB'), findsOneWidget);
      expect(find.text('x-7890'), findsOneWidget);
    }
  });

  testWidgets('limits visible detail rows and supports text scaling', (
    tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: buildSubject(),
      ),
    );
    expect(find.text('Payment'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('exposes a semantic container', (tester) async {
    await tester.pumpWidget(buildSubject());
    final semantics = tester.getSemantics(find.byType(V3Receipt));
    expect(semantics.label, 'Payment receipt');
  });
}
