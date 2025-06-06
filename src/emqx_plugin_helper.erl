%%--------------------------------------------------------------------
%% Copyright (c) 2021-2025 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_plugin_helper).

-export([
    get_config/1
]).

-type name_vsn() :: binary().

%%--------------------------------------------------------------------
%% API
%%--------------------------------------------------------------------

-spec get_config(name_vsn()) -> term().
get_config(NameVsn) ->
    case emqx_plugins:get_config(NameVsn) of
        %% Pre-5.9.0
        {ok, Config} when is_map(Config) -> Config;
        %% ~> 5.9.0
        Config when is_map(Config) -> Config;
        _ -> #{}
    end.
