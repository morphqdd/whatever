import gleam/result
import gleam/string

fn is_upper(str: String) -> Bool {
  str == string.uppercase(str)
}

pub fn to_atom_string(str: String, acc: String) -> Result(String, Nil) {
  case string.is_empty(str) {
    True -> Ok(string.slice(acc, 1, string.length(acc)))
    False -> {
      let slice = string.slice(str, 1, string.length(str))
      use char <- result.try(string.first(str))
      case is_upper(char) {
        True ->
          to_atom_string(
            slice,
            string.append(acc, "_") |> string.append(string.lowercase(char)),
          )
        False -> to_atom_string(slice, string.append(acc, char))
      }
    }
  }
}
