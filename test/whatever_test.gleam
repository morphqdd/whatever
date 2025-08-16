import gleam/option
import gleeunit
import whatever
import whatever/result.{type WResult}

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
    Error(err) -> {
      let err = whatever.downcast(whatever.ToType("MyError"), err)
      assert option.Some(MyError) == err
    }
    _ -> Nil
  }
  case maybe_fail(False) {
    Error(err) -> {
      let err = whatever.downcast(whatever.ToType("MyError"), err)
      assert option.None == err
    }
    _ -> Nil
  }
}

pub fn maybe_fail(is_failure: Bool) -> WResult(Nil) {
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
