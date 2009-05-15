inotify:start(self()).

{ok, _F} = inotify:open(),
{ok, W} = inotify:add("../test", all),
TestListener1 = fun(F) ->
  receive
        stop -> ok;
        Msg ->
          io:format("listener got: ~p~n", [Msg]),
         F(F)
       end
    end,
TestListener = fun() -> TestListener1(TestListener1) end.
Listener = spawn(TestListener),
inotify:controlling_process(Listener).
