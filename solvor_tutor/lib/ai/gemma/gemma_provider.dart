import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'gemma_service.dart';

enum GemmaDownloadStatus { notDownloaded, downloading, ready, error }

class GemmaDownloadState {
  final GemmaDownloadStatus status;
  final double progress;
  final String? error;

  const GemmaDownloadState({
    this.status = GemmaDownloadStatus.notDownloaded,
    this.progress = 0.0,
    this.error,
  });

  GemmaDownloadState copyWith({
    GemmaDownloadStatus? status,
    double? progress,
    String? error,
  }) {
    return GemmaDownloadState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error,
    );
  }
}

class GemmaDownloadNotifier extends StateNotifier<GemmaDownloadState> {
  GemmaDownloadNotifier() : super(const GemmaDownloadState());

  Future<void> checkStatus() async {
    final installed = await GemmaService.instance.isModelInstalled();
    if (installed) {
      state = const GemmaDownloadState(status: GemmaDownloadStatus.ready);
    }
  }

  Future<void> startDownload() async {
    state = const GemmaDownloadState(
      status: GemmaDownloadStatus.downloading,
      progress: 0.0,
    );

    try {
      await GemmaService.instance.downloadModel(
        onProgress: (p) {
          if (state.status == GemmaDownloadStatus.downloading) {
            state = state.copyWith(progress: p);
          }
        },
      );
      await GemmaService.instance.loadModel();
      state = const GemmaDownloadState(status: GemmaDownloadStatus.ready);
    } catch (e) {
      state = GemmaDownloadState(
        status: GemmaDownloadStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteModel() async {
    await GemmaService.instance.uninstallModel();
    state = const GemmaDownloadState(
      status: GemmaDownloadStatus.notDownloaded,
    );
  }
}

final gemmaDownloadStatusProvider =
    StateNotifierProvider<GemmaDownloadNotifier, GemmaDownloadState>((ref) {
  final notifier = GemmaDownloadNotifier();
  notifier.checkStatus();
  return notifier;
});

final gemmaAnswerProvider =
    StreamProvider.autoDispose.family<String, String>((ref, query) {
  // Do NOT dispose the singleton here — it manages its own lifecycle.
  // autoDispose only cancels the stream subscription, which is correct.
  return GemmaService.instance.generateAnswer(query);
});
