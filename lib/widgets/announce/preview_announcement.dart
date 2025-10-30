import 'package:flutter/material.dart';
import 'announcement.dart';

/// Preview component for AnnouncementCard
/// Allows customization of background color and alignment only
/// All component properties are fixed
///
/// Example usage:
/// ```dart
/// AnnouncementPreview(
///   backgroundColor: Colors.black,
///   alignment: Alignment.center,
/// )
/// ```

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: AnnouncementPreview()),
    ),
  );
}

class AnnouncementPreview extends StatefulWidget {
  /// Background color of the preview
  final Color backgroundColor;

  /// Alignment of the component
  final Alignment alignment;

  const AnnouncementPreview({
    super.key,
    this.backgroundColor = const Color(0xFF1E1E1E),
    this.alignment = Alignment.center,
  });

  @override
  State<AnnouncementPreview> createState() => _AnnouncementPreviewState();
}

class _AnnouncementPreviewState extends State<AnnouncementPreview> {
  late List<String> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      'The money withdrawal system will return to service as usual. From 31/05/2022 at 4:30 PM (Thailand time) onwards.',
      'We are currently upgrading our security infrastructure. Services will resume by 31/05/2022 at 5:00 PM (Thailand time).',
      'Your account has been verified successfully. All features are now fully accessible from 01/06/2022 at 8:00 AM (Thailand time).',
    ];
  }

  void _updateMessages() {
    // This is where you would typically fetch new messages from an API
    // For now, we'll just rotate the messages
    setState(() {
      _messages = [..._messages.sublist(1), _messages[0]];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: AnnouncementStack(
              messages: _messages,
              onClose: _updateMessages,
            ),
          ),
        ],
      ),
    );
  }
}
