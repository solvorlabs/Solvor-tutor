import 'dart:io';

import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final Future<File?> Function() onCapture;
  final ValueChanged<String> onTextExtracted;

  const CameraScreen({
    super.key,
    required this.onCapture,
    required this.onTextExtracted,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  bool _processing = false;

  Future<void> _capture() async {
    setState(() => _processing = true);
    try {
      final file = await widget.onCapture();
      if (file != null) {
        setState(() => _image = file);
      }
    } finally {
      setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Question')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _image!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _processing ? null : _capture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Retake'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _processing
                    ? null
                    : () {
                        // Extract text is handled by parent via onTextExtracted
                        Navigator.of(context).pop();
                      },
                icon: const Icon(Icons.check),
                label: const Text('Use This Image'),
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: _processing ? null : _capture,
                icon: _processing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.camera_alt),
                label: Text(_processing ? 'Processing...' : 'Capture Image'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
