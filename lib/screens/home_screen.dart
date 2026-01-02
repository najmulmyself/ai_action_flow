import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  final FocusNode _textFocusNode = FocusNode();
  int? _selectionStart;
  int? _selectionEnd;
  bool _keepSelectionHighlight = false;
  final GlobalKey _textKey = GlobalKey();

  final String _paragraph1 =
      '''Misspellings and grammatical errors can effect your credibility. The same goes for misused commas, and other''';

  final String _paragraph1Rest =
      ''' types of punctuation . Not only will Grammarly underline these issues in red, it will also showed you how to correctly write the sentence.''';

  final String _paragraph2 =
      '''Underlines that are blue indicate that Grammarly has spotted a sentence that is unnecessarily wordy. You'll find suggestions that can possibly help you revise a wordy sentence in an effortless manner.''';

  void _onSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    if (selection.baseOffset != selection.extentOffset) {
      setState(() {
        _selection = selection;
        _selectionStart = selection.baseOffset;
        _selectionEnd = selection.extentOffset;
        _keepSelectionHighlight = false;
        _popupPosition = Offset(
          MediaQuery.of(context).size.width / 2 - 80,
          MediaQuery.of(context).size.height / 2,
        );
      });
    } else if (!_keepSelectionHighlight) {
      setState(() {
        _selection = null;
        _popupPosition = null;
        _selectionStart = null;
        _selectionEnd = null;
      });
    }
  }

  Widget _buildHighlightedText() {
    final fullText = '$_paragraph1$_paragraph1Rest\n\n$_paragraph2';
    final start = _selectionStart ?? 0;
    final end = _selectionEnd ?? fullText.length;

    final beforeSelection = fullText.substring(0, start);
    final selectedText = fullText.substring(start, end);
    final afterSelection = fullText.substring(end);

    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 17,
          height: 1.5,
          color: Color(0xFF000000),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(text: beforeSelection),
          TextSpan(
            text: selectedText,
            style: TextStyle(
              backgroundColor: const Color(0xFF2196F3).withOpacity(0.3),
            ),
          ),
          TextSpan(text: afterSelection),
        ],
      ),
    );
  }

  void _showActionSheet() {
    setState(() {
      _keepSelectionHighlight = true;
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    action,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _toastEntry?.remove();
                    _toastEntry = null;
                    // Clearing selection and popup
                    setState(() {
                      _selection = null;
                      _popupPosition = null;
                      _selectionStart = null;
                      _selectionEnd = null;
                      _keepSelectionHighlight = false;
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Color(0xFF000000),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_toastEntry!);
  }

  @override
  void dispose() {
    _toastEntry?.remove();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WikipediA',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Stack(
                    children: [
                      if (_keepSelectionHighlight &&
                          _selectionStart != null &&
                          _selectionEnd != null)
                        _buildHighlightedText(),
                      Opacity(
                        opacity: _keepSelectionHighlight ? 0 : 1,
                        child: SelectableText(
                          key: _textKey,
                          '$_paragraph1$_paragraph1Rest\n\n$_paragraph2',
                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                          ),
                          selectionColor: const Color(
                            0xFF2196F3,
                          ).withOpacity(0.3),
                          onSelectionChanged: _onSelectionChanged,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (_selection != null && _popupPosition != null)
              Positioned(
                bottom: 40,
                right: 24,
                child: GestureDetector(
                  onTap: _showActionSheet,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2196F3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.sparkles,
                      color: Color(0xFF2196F3),
                      size: 28,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
