import 'dart:async';
import 'package:contentstack/client.dart';

/// Assets refer to all the media files (images, videos, PDFs, audio files, and so on)
/// uploaded in your Contentstack repository for future use. These files can be
/// attached and used in multiple entries. Learn more about Assets.
/// https://www.contentstack.com/docs/content-managers/work-with-assets
///
/// * All Assets
/// This call fetches the list of all the assets of a particular stack
///
/// * Single Asset
/// This call fetches the latest version of a specific asset of a particular stack.
///
class Asset {
  final HttpClient _client;
  final String _uid;
  String _urlPath;
  final Map<String, dynamic> assetParameter = <String, dynamic>{};

  Asset(this._uid, [this._client]) {
    assetParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = "/${_client.stack.apiVersion}/assets";
  }

  ///
  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  ///
  void environment(String environment) {
    assetParameter["environment"] = environment;
  }

  ///
  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified, the details of the latest version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  ///
  void version(int version) {
    assetParameter["version"] = version.toString();
  }


  /// It fetch single asset data on the basis of the asset uid.
  Future<dynamic> fetch() {
    if (_uid == null) {throw Exception('Provide asset uid to fetch single entry');}
    final uri = Uri.https(_client.stack.endpoint, "$_urlPath/$_uid", assetParameter);
    return _client.sendRequest(uri);
  }

}
