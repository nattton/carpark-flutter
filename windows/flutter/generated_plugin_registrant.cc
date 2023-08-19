//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <charset_converter/charset_converter_plugin.h>
#include <dart_vlc/dart_vlc_plugin.h>
#include <file_saver/file_saver_plugin.h>
#include <flutter_pos_printer_platform/flutter_pos_printer_platform_plugin.h>
#include <network_info_plus_windows/network_info_plus_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CharsetConverterPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CharsetConverterPlugin"));
  DartVlcPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("DartVlcPlugin"));
  FileSaverPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSaverPlugin"));
  FlutterPosPrinterPlatformPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterPosPrinterPlatformPlugin"));
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
}
