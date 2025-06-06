%%--------------------------------------------------------------------
%% Copyright (c) 2017-2025 EMQ Technologies Co., Ltd. All Rights Reserved.
%%--------------------------------------------------------------------

-ifndef(EMQX_MQTT_HRL).
-define(EMQX_MQTT_HRL, true).

-define(UINT_MAX, 16#FFFFFFFF).

%%--------------------------------------------------------------------
%% MQTT Protocol Version and Names
%%--------------------------------------------------------------------

-define(MQTT_SN_PROTO_V1, 1).
-define(MQTT_PROTO_V3, 3).
-define(MQTT_PROTO_V4, 4).
-define(MQTT_PROTO_V5, 5).

-define(PROTOCOL_NAMES, [
    %% XXX:Compatible with emqx-sn plug-in
    {?MQTT_SN_PROTO_V1, <<"MQTT-SN">>},
    {?MQTT_PROTO_V3, <<"MQIsdp">>},
    {?MQTT_PROTO_V4, <<"MQTT">>},
    {?MQTT_PROTO_V5, <<"MQTT">>}
]).

%%--------------------------------------------------------------------
%% MQTT Topic and TopitFilter byte length
%%--------------------------------------------------------------------

%% MQTT-3.1.1 and MQTT-5.0 [MQTT-4.7.3-3]
-define(MAX_TOPIC_LEN, 65535).

%%--------------------------------------------------------------------
%% MQTT Share-Sub Internal
%%--------------------------------------------------------------------

-record(share, {group :: emqx_plugin_helper_types:group(), topic :: emqx_plugin_helper_types:topic()}).

%% guards
-define(IS_TOPIC(T),
    (is_binary(T) orelse is_record(T, share))
).

%%--------------------------------------------------------------------
%% MQTT QoS Levels
%%--------------------------------------------------------------------

%% At most once
-define(QOS_0, 0).
%% At least once
-define(QOS_1, 1).
%% Exactly once
-define(QOS_2, 2).

-define(IS_QOS(I), (I >= ?QOS_0 andalso I =< ?QOS_2)).

-define(QOS_I(Name), begin
    (case Name of
        ?QOS_0 -> ?QOS_0;
        qos0 -> ?QOS_0;
        at_most_once -> ?QOS_0;
        ?QOS_1 -> ?QOS_1;
        qos1 -> ?QOS_1;
        at_least_once -> ?QOS_1;
        ?QOS_2 -> ?QOS_2;
        qos2 -> ?QOS_2;
        exactly_once -> ?QOS_2
    end)
end).

-define(IS_QOS_NAME(I),
    (I =:= qos0 orelse I =:= at_most_once orelse
        I =:= qos1 orelse I =:= at_least_once orelse
        I =:= qos2 orelse I =:= exactly_once)
).

%%--------------------------------------------------------------------
%% Maximum ClientId Length.
%%--------------------------------------------------------------------

-define(MAX_CLIENTID_LEN, 65535).

%%--------------------------------------------------------------------
%% MQTT Control Packet Types
%%--------------------------------------------------------------------

%% Reserved
-define(RESERVED, 0).
%% Client request to connect to Server
-define(CONNECT, 1).
%% Server to Client: Connect acknowledgment
-define(CONNACK, 2).
%% Publish message
-define(PUBLISH, 3).
%% Publish acknowledgment
-define(PUBACK, 4).
%% Publish received (assured delivery part 1)
-define(PUBREC, 5).
%% Publish release (assured delivery part 2)
-define(PUBREL, 6).
%% Publish complete (assured delivery part 3)
-define(PUBCOMP, 7).
%% Client subscribe request
-define(SUBSCRIBE, 8).
%% Server Subscribe acknowledgment
-define(SUBACK, 9).
%% Unsubscribe request
-define(UNSUBSCRIBE, 10).
%% Unsubscribe acknowledgment
-define(UNSUBACK, 11).
%% PING request
-define(PINGREQ, 12).
%% PING response
-define(PINGRESP, 13).
%% Client or Server is disconnecting
-define(DISCONNECT, 14).
%% Authentication exchange
-define(AUTH, 15).

%%--------------------------------------------------------------------
%% MQTT V3.1.1 Connect Return Codes
%%--------------------------------------------------------------------

%% Connection accepted
-define(CONNACK_ACCEPT, 0).
%% Unacceptable protocol version
-define(CONNACK_PROTO_VER, 1).
%% Client Identifier is correct UTF-8 but not allowed by the Server
-define(CONNACK_INVALID_ID, 2).
%% Server unavailable
-define(CONNACK_SERVER, 3).
%% Username or password is malformed
-define(CONNACK_CREDENTIALS, 4).
%% Client is not authorized to connect
-define(CONNACK_AUTH, 5).

%%--------------------------------------------------------------------
%% MQTT V5.0 Reason Codes
%%--------------------------------------------------------------------

-define(RC_SUCCESS, 16#00).
-define(RC_NORMAL_DISCONNECTION, 16#00).
-define(RC_GRANTED_QOS_0, 16#00).
-define(RC_GRANTED_QOS_1, 16#01).
-define(RC_GRANTED_QOS_2, 16#02).
-define(RC_DISCONNECT_WITH_WILL_MESSAGE, 16#04).
-define(RC_NO_MATCHING_SUBSCRIBERS, 16#10).
-define(RC_NO_SUBSCRIPTION_EXISTED, 16#11).
-define(RC_CONTINUE_AUTHENTICATION, 16#18).
-define(RC_RE_AUTHENTICATE, 16#19).
-define(RC_UNSPECIFIED_ERROR, 16#80).
-define(RC_MALFORMED_PACKET, 16#81).
-define(RC_PROTOCOL_ERROR, 16#82).
-define(RC_IMPLEMENTATION_SPECIFIC_ERROR, 16#83).
-define(RC_UNSUPPORTED_PROTOCOL_VERSION, 16#84).
-define(RC_CLIENT_IDENTIFIER_NOT_VALID, 16#85).
-define(RC_BAD_USER_NAME_OR_PASSWORD, 16#86).
-define(RC_NOT_AUTHORIZED, 16#87).
-define(RC_SERVER_UNAVAILABLE, 16#88).
-define(RC_SERVER_BUSY, 16#89).
-define(RC_BANNED, 16#8A).
-define(RC_SERVER_SHUTTING_DOWN, 16#8B).
-define(RC_BAD_AUTHENTICATION_METHOD, 16#8C).
-define(RC_KEEP_ALIVE_TIMEOUT, 16#8D).
-define(RC_SESSION_TAKEN_OVER, 16#8E).
-define(RC_TOPIC_FILTER_INVALID, 16#8F).
-define(RC_TOPIC_NAME_INVALID, 16#90).
-define(RC_PACKET_IDENTIFIER_IN_USE, 16#91).
-define(RC_PACKET_IDENTIFIER_NOT_FOUND, 16#92).
-define(RC_RECEIVE_MAXIMUM_EXCEEDED, 16#93).
-define(RC_TOPIC_ALIAS_INVALID, 16#94).
-define(RC_PACKET_TOO_LARGE, 16#95).
-define(RC_MESSAGE_RATE_TOO_HIGH, 16#96).
-define(RC_QUOTA_EXCEEDED, 16#97).
-define(RC_ADMINISTRATIVE_ACTION, 16#98).
-define(RC_PAYLOAD_FORMAT_INVALID, 16#99).
-define(RC_RETAIN_NOT_SUPPORTED, 16#9A).
-define(RC_QOS_NOT_SUPPORTED, 16#9B).
-define(RC_USE_ANOTHER_SERVER, 16#9C).
-define(RC_SERVER_MOVED, 16#9D).
-define(RC_SHARED_SUBSCRIPTIONS_NOT_SUPPORTED, 16#9E).
-define(RC_CONNECTION_RATE_EXCEEDED, 16#9F).
-define(RC_MAXIMUM_CONNECT_TIME, 16#A0).
-define(RC_SUBSCRIPTION_IDENTIFIERS_NOT_SUPPORTED, 16#A1).
-define(RC_WILDCARD_SUBSCRIPTIONS_NOT_SUPPORTED, 16#A2).

%%--------------------------------------------------------------------
%% Maximum MQTT Packet ID and Length
%%--------------------------------------------------------------------

-define(MAX_PACKET_ID, 16#FFFF).
-define(MAX_PACKET_SIZE, 16#FFFFFFF).
-define(MAX_TOPIC_AlIAS, 16#FFFF).
-define(RECEIVE_MAXIMUM_LIMIT, ?MAX_PACKET_ID).

%%--------------------------------------------------------------------
%% MQTT Frame Mask
%%--------------------------------------------------------------------

-define(HIGHBIT, 2#10000000).
-define(LOWBITS, 2#01111111).

%%--------------------------------------------------------------------
%% MQTT Packet Fixed Header
%%--------------------------------------------------------------------

-record(mqtt_packet_header, {
    type = ?RESERVED,
    dup = false,
    qos = ?QOS_0,
    retain = false
}).

%%--------------------------------------------------------------------
%% MQTT Packets
%%--------------------------------------------------------------------

%% Retain Handling
-define(DEFAULT_SUBOPTS, #{
    rh => 0,
    %% Retain as Publish
    rap => 0,
    %% No Local
    nl => 0,
    %% QoS
    qos => 0
}).

-record(mqtt_packet_connect, {
    proto_name = <<"MQTT">>,
    proto_ver = ?MQTT_PROTO_V4,
    is_bridge = false,
    clean_start = true,
    will_flag = false,
    will_qos = ?QOS_0,
    will_retain = false,
    keepalive = 0,
    properties = #{},
    clientid = <<>>,
    will_props = #{},
    will_topic = undefined,
    will_payload = undefined,
    username = undefined,
    password = undefined
}).

-record(mqtt_packet_connack, {
    ack_flags,
    reason_code,
    properties = #{}
}).

-record(mqtt_packet_publish, {
    topic_name,
    packet_id,
    properties = #{}
}).

-record(mqtt_packet_puback, {
    packet_id,
    reason_code,
    properties = #{}
}).

-record(mqtt_packet_subscribe, {
    packet_id,
    properties = #{},
    topic_filters
}).

-record(mqtt_packet_suback, {
    packet_id,
    properties = #{},
    reason_codes
}).

-record(mqtt_packet_unsubscribe, {
    packet_id,
    properties = #{},
    topic_filters
}).

-record(mqtt_packet_unsuback, {
    packet_id,
    properties = #{},
    reason_codes
}).

-record(mqtt_packet_disconnect, {
    reason_code,
    properties = #{}
}).

-record(mqtt_packet_auth, {
    reason_code,
    properties = #{}
}).

%%--------------------------------------------------------------------
%% MQTT Implementation Internal
%%--------------------------------------------------------------------

%% Propagate extra data in MQTT Packets
%% Use it in properties and should never be serialized
%% See also emqx_frame:serialize_property/3
-define(MQTT_INTERNAL_EXTRA, 'internal_extra').

%%--------------------------------------------------------------------
%% MQTT Control Packet
%%--------------------------------------------------------------------

-record(mqtt_packet, {
    header :: #mqtt_packet_header{},
    variable ::
        #mqtt_packet_connect{}
        | #mqtt_packet_connack{}
        | #mqtt_packet_publish{}
        %% QoS=1: PUBACK,
        %% QoS=2: PUBREC, PUBREL, PUBCOMP
        %% all used #mqtt_packet_puback{}
        | #mqtt_packet_puback{}
        | #mqtt_packet_subscribe{}
        | #mqtt_packet_suback{}
        | #mqtt_packet_unsubscribe{}
        | #mqtt_packet_unsuback{}
        | #mqtt_packet_disconnect{}
        | #mqtt_packet_auth{}
        | pos_integer()
        | undefined,
    payload :: binary() | undefined
}).

%%--------------------------------------------------------------------
%% MQTT Message Internal
%%--------------------------------------------------------------------

-record(mqtt_msg, {
    qos = ?QOS_0,
    retain = false,
    dup = false,
    packet_id,
    topic,
    props,
    payload
}).

%%--------------------------------------------------------------------
%% MQTT Packet Match
%%--------------------------------------------------------------------

-define(PACKET(Type), #mqtt_packet{
    header = #mqtt_packet_header{type = Type}
}).

-define(PACKET(Type, Var), #mqtt_packet{
    header = #mqtt_packet_header{type = Type},
    variable = Var
}).

-define(PACKET(Type, Var, Payload), #mqtt_packet{
    header = #mqtt_packet_header{type = Type},
    variable = Var,
    payload = Payload
}).

-define(CONNECT_PACKET(), #mqtt_packet{header = #mqtt_packet_header{type = ?CONNECT}}).

-define(CONNECT_PACKET(Var), #mqtt_packet{
    header = #mqtt_packet_header{type = ?CONNECT},
    variable = Var
}).

-define(CONNACK_PACKET(ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?CONNACK},
    variable = #mqtt_packet_connack{
        ack_flags = 0,
        reason_code = ReasonCode
    }
}).

-define(CONNACK_PACKET(ReasonCode, SessPresent), #mqtt_packet{
    header = #mqtt_packet_header{type = ?CONNACK},
    variable = #mqtt_packet_connack{
        ack_flags = SessPresent,
        reason_code = ReasonCode
    }
}).

-define(CONNACK_PACKET(ReasonCode, SessPresent, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?CONNACK},
    variable = #mqtt_packet_connack{
        ack_flags = SessPresent,
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(AUTH_PACKET(), #mqtt_packet{
    header = #mqtt_packet_header{type = ?AUTH},
    variable = #mqtt_packet_auth{reason_code = 0}
}).

-define(AUTH_PACKET(ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?AUTH},
    variable = #mqtt_packet_auth{reason_code = ReasonCode}
}).

-define(AUTH_PACKET(ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?AUTH},
    variable = #mqtt_packet_auth{
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(PUBLISH_PACKET(QoS), #mqtt_packet{header = #mqtt_packet_header{type = ?PUBLISH, qos = QoS}}).

-define(PUBLISH_PACKET(QoS, PacketId), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBLISH,
        qos = QoS
    },
    variable = #mqtt_packet_publish{packet_id = PacketId}
}).

-define(PUBLISH_PACKET(QoS, Topic, PacketId), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBLISH,
        qos = QoS
    },
    variable = #mqtt_packet_publish{
        topic_name = Topic,
        packet_id = PacketId
    }
}).

-define(PUBLISH_PACKET(QoS, Topic, PacketId, Payload), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBLISH,
        qos = QoS
    },
    variable = #mqtt_packet_publish{
        topic_name = Topic,
        packet_id = PacketId
    },
    payload = Payload
}).

-define(PUBLISH_PACKET(QoS, Topic, PacketId, Properties, Payload), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBLISH,
        qos = QoS
    },
    variable = #mqtt_packet_publish{
        topic_name = Topic,
        packet_id = PacketId,
        properties = Properties
    },
    payload = Payload
}).

-define(PUBACK_PACKET(PacketId), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBACK},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = 0
    }
}).

-define(PUBACK_PACKET(PacketId, ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBACK},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode
    }
}).

-define(PUBACK_PACKET(PacketId, ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBACK},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(PUBREC_PACKET(PacketId), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBREC},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = 0
    }
}).

-define(PUBREC_PACKET(PacketId, ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBREC},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode
    }
}).

-define(PUBREC_PACKET(PacketId, ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBREC},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(PUBREL_PACKET(PacketId), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBREL,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = 0
    }
}).

-define(PUBREL_PACKET(PacketId, ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBREL,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode
    }
}).

-define(PUBREL_PACKET(PacketId, ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?PUBREL,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(PUBCOMP_PACKET(PacketId), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBCOMP},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = 0
    }
}).

-define(PUBCOMP_PACKET(PacketId, ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBCOMP},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode
    }
}).

-define(PUBCOMP_PACKET(PacketId, ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?PUBCOMP},
    variable = #mqtt_packet_puback{
        packet_id = PacketId,
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(SUBSCRIBE_PACKET(PacketId, TopicFilters), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?SUBSCRIBE,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_subscribe{
        packet_id = PacketId,
        topic_filters = TopicFilters
    }
}).

-define(SUBSCRIBE_PACKET(PacketId, Properties, TopicFilters), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?SUBSCRIBE,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_subscribe{
        packet_id = PacketId,
        properties = Properties,
        topic_filters = TopicFilters
    }
}).

-define(SUBACK_PACKET(PacketId, ReasonCodes), #mqtt_packet{
    header = #mqtt_packet_header{type = ?SUBACK},
    variable = #mqtt_packet_suback{
        packet_id = PacketId,
        reason_codes = ReasonCodes
    }
}).

-define(SUBACK_PACKET(PacketId, Properties, ReasonCodes), #mqtt_packet{
    header = #mqtt_packet_header{type = ?SUBACK},
    variable = #mqtt_packet_suback{
        packet_id = PacketId,
        properties = Properties,
        reason_codes = ReasonCodes
    }
}).

-define(UNSUBSCRIBE_PACKET(PacketId, TopicFilters), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?UNSUBSCRIBE,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_unsubscribe{
        packet_id = PacketId,
        topic_filters = TopicFilters
    }
}).

-define(UNSUBSCRIBE_PACKET(PacketId, Properties, TopicFilters), #mqtt_packet{
    header = #mqtt_packet_header{
        type = ?UNSUBSCRIBE,
        qos = ?QOS_1
    },
    variable = #mqtt_packet_unsubscribe{
        packet_id = PacketId,
        properties = Properties,
        topic_filters = TopicFilters
    }
}).

-define(UNSUBACK_PACKET(PacketId), #mqtt_packet{
    header = #mqtt_packet_header{type = ?UNSUBACK},
    variable = #mqtt_packet_unsuback{packet_id = PacketId}
}).

-define(UNSUBACK_PACKET(PacketId, ReasonCodes), #mqtt_packet{
    header = #mqtt_packet_header{type = ?UNSUBACK},
    variable = #mqtt_packet_unsuback{
        packet_id = PacketId,
        reason_codes = ReasonCodes
    }
}).

-define(UNSUBACK_PACKET(PacketId, Properties, ReasonCodes), #mqtt_packet{
    header = #mqtt_packet_header{type = ?UNSUBACK},
    variable = #mqtt_packet_unsuback{
        packet_id = PacketId,
        properties = Properties,
        reason_codes = ReasonCodes
    }
}).

-define(DISCONNECT_PACKET(), #mqtt_packet{
    header = #mqtt_packet_header{type = ?DISCONNECT},
    variable = #mqtt_packet_disconnect{reason_code = 0}
}).

-define(DISCONNECT_PACKET(ReasonCode), #mqtt_packet{
    header = #mqtt_packet_header{type = ?DISCONNECT},
    variable = #mqtt_packet_disconnect{reason_code = ReasonCode}
}).

-define(DISCONNECT_PACKET(ReasonCode, Properties), #mqtt_packet{
    header = #mqtt_packet_header{type = ?DISCONNECT},
    variable = #mqtt_packet_disconnect{
        reason_code = ReasonCode,
        properties = Properties
    }
}).

-define(SHARE, "$share").
-define(QUEUE, "$queue").

-define(REDISPATCH_TO(GROUP, TOPIC), {GROUP, TOPIC}).

-define(SHARE_EMPTY_FILTER, share_subscription_topic_cannot_be_empty).
-define(SHARE_EMPTY_GROUP, share_subscription_group_name_cannot_be_empty).
-define(SHARE_RECURSIVELY, '$share_cannot_be_used_as_real_topic_filter').
-define(SHARE_NAME_INVALID_CHAR, share_subscription_group_name_cannot_include_wildcard).

-define(FRAME_PARSE_ERROR, frame_parse_error).
-define(FRAME_SERIALIZE_ERROR, frame_serialize_error).

-define(THROW_FRAME_ERROR(Reason), erlang:throw({?FRAME_PARSE_ERROR, Reason})).
-define(THROW_SERIALIZE_ERROR(Reason), erlang:throw({?FRAME_SERIALIZE_ERROR, Reason})).

-endif.
