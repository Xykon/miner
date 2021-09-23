%%%-------------------------------------------------------------------
%% @doc
%% == Miner PoC ==
%% @end
%%%-------------------------------------------------------------------
-module(miner_poc).

-export([
    dial_framed_stream/3,
    add_stream_handler/1
]).

-define(POC_VERSION, "miner_poc/1.0.0").

%%--------------------------------------------------------------------
%% @doc
%% Dial PoC stream
%% @end
%%--------------------------------------------------------------------
-spec dial_framed_stream(pid(), string(), list()) -> {ok, pid()} | {error, any()} | ignore.
dial_framed_stream(Swarm, Address, Args) ->
    libp2p_swarm:dial_framed_stream(
        Swarm,
        Address,
        ?POC_VERSION,
        miner_poc_report_handler,
        Args
    ).

%%--------------------------------------------------------------------
%% @doc
%% @end
%%--------------------------------------------------------------------
-spec add_stream_handler(pid() | ets:tab()) -> ok.
add_stream_handler(SwarmTID) ->
    libp2p_swarm:add_stream_handler(
        SwarmTID,
        ?POC_VERSION,
        {libp2p_framed_stream, server, [miner_poc_report_handler, self(), SwarmTID]}
    ).
