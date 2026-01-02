import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActionBottomSheetWidget extends StatefulWidget {
  final Function(String) onActionSelected;

  const ActionBottomSheetWidget({
    super.key,
    required this.onActionSelected,
  });

  @override
  State<ActionBottomSheetWidget> createState() =>
      _ActionBottomSheetWidgetState();
}

class _ActionBottomSheetWidgetState extends State<ActionBottomSheetWidget> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _handleAction(String action) {
    Navigator.pop(context);
    widget.onActionSelected(action);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _promptController,
                            decoration: const InputDecoration(
                              hintText: 'Write a promt here...',
                              hintStyle: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          CupertinoIcons.paperplane,
                          color: const Color(0xFF7B8794),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final buttonWidth = (constraints.maxWidth - 12) / 2;
                      return Column(
                        children: [
                          Row(
                            children: [
                              _ActionButton(
                                label: 'Improve Writting',
                                width: buttonWidth,
                                onTap: () => _handleAction('Improve Writing Selected'),
                              ),
                              const SizedBox(width: 12),
                              _ActionButton(
                                label: 'Plagiarism Check',
                                width: buttonWidth,
                                onTap: () => _handleAction('Plagiarism Check Selected'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _ActionButton(
                                label: 'Regererate',
                                width: buttonWidth,
                                onTap: () => _handleAction('Regenerate Selected'),
                              ),
                              const SizedBox(width: 12),
                              _ActionButton(
                                label: 'Add a summary',
                                width: buttonWidth,
                                onTap: () => _handleAction('Add Summary Selected'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _ActionButton(
                                label: 'Add a summary',
                                width: buttonWidth,
                                onTap: () => _handleAction('Add Summary Selected'),
                              ),
                              const SizedBox(width: 12),
                              _ActionButton(
                                label: 'Add a summary',
                                width: buttonWidth,
                                onTap: () => _handleAction('Add Summary Selected'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleAction('Insert'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2196F3),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Insert',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: () => _handleAction('Replace'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF2196F3),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Replace',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final double width;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.sparkles,
              color: Color(0xFF000000),
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
