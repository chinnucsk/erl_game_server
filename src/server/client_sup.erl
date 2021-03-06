%%-------------------------------------
%% @Module : client_sup
%% @Author : TangYi
%% @Email : tang_yi_1989@qq.com
%% @Created : 2013.09.20
%% @Description : 客户端监控树
%%-------------------------------------

-module(client_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

%%------------------------------- API -----------------------------------

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%------------------------- supervisor callbacks ------------------------
init([]) ->
    {
        ok,
        {
            {simple_one_for_one, 10, 10},
            [
                {
                    client_packet_handler, 
                    {
                        client_packet_handler, start_link, []
                    },
                    temporary,
                    brutal_kill,
                    worker,
                    [client_packet_handler]
                }
            ]
        }
    }.