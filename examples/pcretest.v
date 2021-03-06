import pcre

fn main() {
  r := pcre.new_regex('Match everything after this: (.+)', 0) or {
    println('An error occured!')
    return
  }

  m := r.match_str('Match everything after this: "I ❤️ VLang!"', 0, 0) or {
    println('No match!')
    return
  }

  // m.get(0) -> Match everything after this: "I ❤️ VLang!"
  // m.get(1) -> "I ❤️ VLang!"'
  // m.get(2) -> Error!
  whole_match := m.get(0) or {
    println('We matched nothing...')
    return
  }

  matched_str := m.get(1) or {
    println('We matched nothing...')
    return
  }

  println(whole_match) // Match everything after this: "I ❤️ VLang!"
  println(matched_str) // "I ❤️ VLang!"

}