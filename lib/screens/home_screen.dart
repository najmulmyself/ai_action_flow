import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/selection_popup.dart';
import '../widgets/action_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextSelection? _selection;
  Offset? _popupPosition;
  OverlayEntry? _toastEntry;

  final String _sampleText =
      '''Misspellings and grammatical errors can effect your credibility. The same goes for misused commas, and other types of punctuation. Not only will Grammarly underline these issues in red, it will also showed you how to correctly write the sentence.

Underlines that are blue indicate that Grammarly has spotted a sentence that is unnecessarily wordy. You'll find suggestions that can possibly help you revise a wordy sentence in an effortless manner.''';

  void _onSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    if (selection.baseOffset != selection.extentOffset) {
      setState(() {
        _selection = selection;
        _popupPosition = Offset(
          MediaQuery.of(context).size.width / 2 - 80,
          MediaQuery.of(context).size.height / 2,
        );
      });
    } else {
      // No selection
      setState(() {
        _selection = null;
        _popupPosition = null;
      });
    }
  }

  void _showActionSheet() {
    // Clear selection
    setState(() {
      _selection = null;
      _popupPosition = null;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ActionBottomSheetWidget(onActionSelected: _showToast),
    );
  }

  void _showToast(String action) {
    // Removing existing toast
    _toastEntry?.remove();

    _toastEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(CupertinoIcons.sparkles, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    action,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _toastEntry?.remove();
                    _toastEntry = null;
                  },
                  child: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_toastEntry!);

    // Auto-dismiss after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      _toastEntry?.remove();
      _toastEntry = null;
    });
  }

  @override
  void dispose() {
    _toastEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: SelectableText(
                          _sampleText,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Color(0xFF212121),
                          ),
                          onSelectionChanged: _onSelectionChanged,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),

            // Floating popup button
            if (_selection != null && _popupPosition != null)
              SelectionPopup(
                position: _popupPosition!,
                onTap: _showActionSheet,
              ),
          ],
        ),
      ),
    );
  }
}
