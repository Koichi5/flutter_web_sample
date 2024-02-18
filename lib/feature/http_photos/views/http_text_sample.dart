import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_sample/feature/http_photos/providers/http_text_provider.dart';

class HttpTextSample extends ConsumerWidget {
  const HttpTextSample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(httpTextControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ランダムワード',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.when(
              data: (data) {
                return Column(
                  children: [
                    Text('取得した単語: ${data.values.first}'),
                    Text('取得にかかった秒数（ミリ秒）: ${data.values.last}')
                  ],
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
