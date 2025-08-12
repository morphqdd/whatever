-module(whatever_ffi).
-export([into/1, downcast/2]).

into(Err) -> {whatever_err, Err}.

downcast(Type, Err) -> 
  io:format("type: ~p, err: ~p~n", [Type, Err]),
  case Err of 
    {whatever_err, Atom} when is_atom(Atom) -> 
      case atom_to_binary(Atom) of
        Type -> {some, Atom};
        _ -> none
      end;
    {whatever_err, Tuple} when is_tuple(Tuple) -> 
      case atom_to_binary(element(1, Tuple)) of
        Type -> {some, Tuple};
        _ -> none
      end
  end
.
