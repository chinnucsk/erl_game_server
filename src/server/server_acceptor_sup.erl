%%-------------------------------------
%% @Module : server_acceptor_sup
%% @Author : TangYi
%% @Email : tang_yi_1989@qq.com
%% @Created : 2013.09.19
%% @Description : Acceptor 监控树
%%-------------------------------------

-module(server_acceptor_sup).
-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
    {
        ok,
        {
            {simple_one_for_one, 10, 10},
            [
                {
                    server_acceptor,
                    {
                        server_acceptor, start_link, []
                    },
                    transient,
                    brutal_kill,
                    worker,
                    [server_acceptor]
                }
            ]
        }
    }.
