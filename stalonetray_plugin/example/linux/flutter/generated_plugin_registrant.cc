//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <stalonetray_plugin/stalonetray_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) stalonetray_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "StalonetrayPlugin");
  stalonetray_plugin_register_with_registrar(stalonetray_plugin_registrar);
}
