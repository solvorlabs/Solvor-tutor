import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaService {
  GemmaService._();
  static final GemmaService instance = GemmaService._();

  static const String modelFileName = 'gemma-4-E2B-it-q4.litertlm';
  static const String modelUrl =
      'https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm/resolve/main/gemma-4-E2B-it-q4.litertlm';

  InferenceModel? _model;
  bool _disposed = false;

  bool get isModelLoaded => _model != null && !_disposed;

  void _reset() {
    _disposed = false;
    _model = null;
  }

  Future<bool> isModelInstalled() => FlutterGemma.isModelInstalled(modelFileName);

  Future<void> downloadModel({
    void Function(double progress)? onProgress,
  }) async {
    await FlutterGemma.installModel(
      modelType: ModelType.gemma4,
    ).fromNetwork(modelUrl).withProgress((progress) {
      onProgress?.call(progress / 100.0);
    }).install();
  }

  Future<void> loadModel() async {
    _reset(); // clear disposed flag so re-download works
    _model = await FlutterGemma.getActiveModel(
      maxTokens: 1024,
      preferredBackend: PreferredBackend.gpu,
    );
  }

  Stream<String> generateAnswer(String question) async* {
    if (_model == null || _disposed) {
      await loadModel();
    }

    final model = _model!;
    final chat = await model.createChat(
      systemInstruction:
          'You are Solvor Tutor, an AI assistant for SSC and Banking exam preparation in India. '
          'Answer concisely and accurately. Keep responses under 200 words. '
          'Use simple English. If the question is not about academics, politely redirect.',
    );

    await chat.addQueryChunk(Message.text(text: question, isUser: true));

    final buffer = StringBuffer();
    final stream = chat.generateChatResponseAsync();
    await for (final chunk in stream) {
      if (_disposed) break;
      if (chunk is TextResponse) {
        buffer.write(chunk.token);
        yield buffer.toString(); // always yield full accumulated text
      }
    }
  }

  Future<void> uninstallModel() async {
    await dispose();
    await FlutterGemma.uninstallModel(modelFileName);
    await FlutterGemma.clearActiveInferenceIdentity();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _model?.close();
    _model = null;
  }
}
