import gleam/option
import whatever/result.{WhateverErr,type WhateverErr} as libres
import whatever/utils

pub type ToType {
  ToType(String)
}

pub fn from(res: Result(a, b)) -> libres.Result(a) {
  case res {
    Ok(a) -> libres.Ok(a)
    Error(b) -> libres.Error(into(b))
  }
}

pub fn downcast(ty: ToType, err: WhateverErr) -> option.Option(err) {
  case ty {
    ToType(str) -> 
      case utils.to_atom_string(str, "") {
        Ok(ty) -> downcast_ffi(ty, err)
        Error(_) -> option.None
      }
  }
}


@external(erlang, "whatever_ffi", "downcast")
pub fn downcast_ffi(ty: String, err: WhateverErr) -> option.Option(err)

@external(erlang, "whatever_ffi", "into")
pub fn into(err: err) -> WhateverErr
