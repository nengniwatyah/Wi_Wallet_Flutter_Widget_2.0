import 'package:flutter/material.dart';

import '../../../config/themes/v3/v3_theme_scope.dart';
import 'v3_transaction_success.dart';

void main() => runApp(const V3TransactionSuccessPreview());

class V3TransactionSuccessPreview extends StatefulWidget {
  const V3TransactionSuccessPreview({super.key});

  @override
  State<V3TransactionSuccessPreview> createState() =>
      _V3TransactionSuccessPreviewState();
}

class _V3TransactionSuccessPreviewState
    extends State<V3TransactionSuccessPreview> {
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
              title: const Text('Transaction Success'),
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
                V3TransactionSuccess(
                  confirmationTitle: 'Transaction Confirmed',
                  transactionType: '',
                  amountLabel: '',
                  amount: '5,000.00 THB',
                  feeLabel: 'Fees',
                  fee: '5.00 THB',
                  senderLabel: 'From',
                  senderName: 'Victor Von Doom',
                  senderAccount: 'x-1234',
                  merchantLabel: 'To',
                  merchantName: 'Victor Von Doom',
                  merchantAccount: 'x-7890',
                  dateTimeLabel: 'Date & Time:',
                  dateTime: '2025-10-06 12:00:53',
                  transactionIdLabel: 'Transaction ID:',
                  transactionId: 'WP12345678901234567890',
                  merchantRefIdLabel: 'Merchant Ref ID:',
                  merchantRefId: 'WP12345678901234567890',
                  billerIdLabel: 'Biller ID:',
                  billerId: 'WP12345678901234567890',
                  ref1Label: 'Ref 1:',
                  ref1: 'WP12345678901234567890',
                  ref2Label: 'Ref 2:',
                  ref2: 'WP12345678901234567891',
                  ref3Label: 'Ref 3:',
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
