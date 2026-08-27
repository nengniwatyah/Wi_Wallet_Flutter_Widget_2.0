import 'package:flutter/material.dart';

import '../../../config/themes/v3/v3_theme_scope.dart';
import 'v3_receipt.dart';

void main() => runApp(const V3ReceiptPreview());

class V3ReceiptPreview extends StatefulWidget {
  const V3ReceiptPreview({super.key});

  @override
  State<V3ReceiptPreview> createState() => _V3ReceiptPreviewState();
}

class _V3ReceiptPreviewState extends State<V3ReceiptPreview> {
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: _brightness, useMaterial3: true),
      home: Builder(
        builder: (context) {
          final colors = V3ThemeScope.colorsOf(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppBar(
              title: const Text('V3 Receipt'),
              actions: [
                IconButton(
                  tooltip: 'Toggle theme',
                  onPressed:
                      () => setState(() {
                        _brightness =
                            _brightness == Brightness.light
                                ? Brightness.dark
                                : Brightness.light;
                      }),
                  icon: Icon(
                    _brightness == Brightness.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                V3Receipt(
                  amount: '5,000.00 THB',
                  fee: 'Fees 5.00 THB',
                  senderName: 'Victor Von Doom',
                  senderAccount: 'x-1234',
                  merchantName: 'Victor Von Doom',
                  merchantAccount: 'x-7890',
                  dateTime: '2025-10-06 12:00:53',
                  transactionId: 'WP12345678901234567890',
                  merchantRefId: 'WP12345678901234567890',
                  billerId: 'WP12345678901234567890',
                  ref1: 'WP12345678901234567890',
                  ref2: 'WP12345678901234567891',
                  ref3: 'WP12345678901234567892',
                  footerNoteOne:
                      'Please verify the information and keep the slip for evidence.',
                  footerNoteTwo:
                      'Customer service contact 02-026-6679 operates 24 hours daily.',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
