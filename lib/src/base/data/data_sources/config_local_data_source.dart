import 'package:injectable/injectable.dart';
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart';

@Injectable(env: [Environment.dev])
class ConfigLocalDataSource extends LocalDataSource {
  final String configurationBoxName = 'configurationBox';

  @override
  exec() async {}

  Future<bool> getIntroSeenState() async {
    final configBox = await openEncryptedBox<String?>(configurationBoxName);
    if (configBox.get('seenState') == null) return false;
    return configBox.get('seenState')! == 'true';
  }

  setIntroSeenState(bool seenState) async {
    final configBox = await openEncryptedBox<String?>(configurationBoxName);
    configBox.put('seenState', seenState ? 'true' : 'false');
  }
}
