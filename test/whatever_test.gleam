import gleam/option
import gleeunit
import whatever
import whatever/result as wres

pub fn main() -> Nil {
  gleeunit.main()
}

type MyError {
  MyError
}

type AnotherError {
  AnotherError
}

pub fn whatever_test() -> Nil {
  case maybe_fail(True) {
    wres.Error(err) -> {
      let err = whatever.downcast(whatever.ToType("MyError"), err)
      assert option.Some(MyError) == err
    }
    _ -> Nil
  }
  case maybe_fail(False) {
    wres.Error(err) -> {
      let err = whatever.downcast(whatever.ToType("MyError"), err)
      assert option.None == err
    }
    _ -> Nil
  }
}

pub fn maybe_fail(is_failure: Bool) -> wres.Result(Nil) {
  case is_failure {
    True -> whatever.from(fail())
    False -> whatever.from(another_fail())
  }
}

fn fail() -> Result(Nil, MyError) {
  Error(MyError)
}

fn another_fail() -> Result(Nil, AnotherError) {
  Error(AnotherError)
}
