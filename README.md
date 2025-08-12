# whatever

[![Package Version](https://img.shields.io/hexpm/v/whatever)](https://hex.pm/packages/whatever)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/whatever/)

```sh
gleam add whatever@1
```

## Usage

```gleam
import whatever
import whatever/result as wres
import gleam/string
import gleam/io

type MyError {
    MyError
}

type AnotherError {
    AnotherError
}

pub fn main() -> Nil {
    case maybe_fail(True) {
        wres.Error(err) -> {
            let err = whatever.downcast(whatever.ToType("MyError"), err)
            io.println(string.inspect(err)) // Some(MyError)
        }
        _ -> Nil
    }
    case maybe_fail(False) {
        wres.Error(err) -> {
            let err = whatever.downcast(whatever.ToType("MyError"), err)
            io.println(string.inspect(err)) // None
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
```
