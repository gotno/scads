// vec_fetch
// returns the value of a key, or a given default if the key is missing
//
// for a vector of vec2s, eg `[["key1", "value1"], ["key2", "value2"]]`
// searches for vec2[0], and returns either vec2[1] or `default` if there
// are no search results
function vec_fetch(vector, key, default) =
  let(
    index = search([key], vector, num_returns_per_match = 1, index_col_num = 0)[0],
    value = vector[index][1]
  )
    value == undef ? default : value;

// vec_set
// returns a copy of the vector with a key changed or a new key added
//
// for a vector of vec2s, eg `[["key1", "value1"], ["key2", "value2"]]`
// searches for vec2[0] and if it finds a match, sets vec2[1] as `value`,
// otherwise adds a new [`key`, `value`] pair
function vec_set(vector, key, value) =
  let(index = search([key], vector, num_returns_per_match = 1, index_col_num = 0)[0])
    index == []
      ? concat(vector, [[key, value]])
      : [for(i=[0:len(vector) - 1]) i == index ? [key, value] : vector[i]];
