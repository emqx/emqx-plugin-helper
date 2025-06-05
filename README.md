# EMQX Plugin Helper

EMQX Plugin Helper is a helper library for creating EMQX plugins.

It's main purpose is to provide the most common macros and records from EMQX to the plugin
without the need to depend on a large part of EMQX in compile time.

## Usage

Add as a dependency (the plugin generator will do that automatically) to the plugin's `rebar.lock`:

<!-- Do not update the version manually, use `make bump-version` instead -->
```erlang
{deps,
    [
        {emqx_plugin_helper, {git, "https://github.com/emqx/emqx_plugin_helper.git", {tag, "v5.9.1"}}}
    ]
}
```

In the plugin code, include the necessary headers from EMQX:

```erlang
%% for #message{} record, etc.
-include_lib("emqx_plugin_helper/include/emqx.hrl").

%% For ?SLOG macros, etc.
-include_lib("emqx_plugin_helper/include/logger.hrl").

%% For hook priorities
-include_lib("emqx_plugin_helper/include/emqx_hooks.hrl").

%% For MQTT-related constants
-include_lib("emqx_plugin_helper/include/emqx_mqtt.hrl").
```

## License

This project is licensed under the [Apache-2.0 License](LICENSE).
