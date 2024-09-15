#let block_with_counter = (
  title,
  name,
  fill,
  inset,
  radius,
  content,
) => {
  let heading_counter = counter(heading)
  let theorem_counter = counter(figure)
  let counter_str = context counter(heading).display() + theorem_counter.display()
  let title_line
  if name == none {
    title_line = $bold(title)$ + " " + counter_str
  } else {
    title_line = $bold(title)$  + " " + counter_str + " ("+ name + ") "
  }
  return figure(
    kind: "theroem",
    supplement: title,
  )[ 
    #block(
      fill: fill,
      inset: inset,
      radius: radius,
      [
        #context theorem_counter.step()
        #context theorem_counter.display()
        #title_line
        :
      ] + "\n" + content
    )
  ]
}

#let theorem = (name, content) => block_with_counter(
  "Theorem",
  name,
  rgb("#ffff00"),
  8pt,
  4pt,
  content
)

#let claim = (name, content) => block_with_counter(
  "Claim",
  name,
  rgb("#ffff00"),
  8pt,
  4pt,
  content
)

次回(9/14)
https://github.com/sahasatvik/typst-theorems/blob/main/theorems.typ#L219C1-L278
を参考に、show ruleを関数として定義し、main側から呼び出す
// #show: thmrules.with(qed-symbol: $square$) <- これに当たるものを作る


// 
// Examples.
// 

#set heading(numbering: "1.")

= A <head_1>
== B
=== C

#figure()[
  phi = 2
]<fig_2>

#block_with_counter(
  "Theorem",
  none,
  rgb("#ff0000"),
  8pt,
  4pt,
)[
  hoge hogehogehogehogehogehogehoge
]
#block_with_counter(
  "Theorem",
  "Name of this",
  rgb("#ff0000"),
  8pt,
  4pt,
)[
  hogehogehogehogehogehogehogehoge
]
#block_with_counter(
  "Theorem",
  "Name of this",
  rgb("#ff0000"),
  8pt,
  4pt,
)[
  hoge
]

#figure()[
  phi = 1
]<fig_1>

#theorem("aaa")[
  phi = 1
  "AAAAA"
  
  $1234$

  @fuga

  @hoge

  $
  "AAAAA"
  $
]<fuga>

#claim(none)[
  $
    1 * 3 - 1 = 2
  $
]<hoge2>
#claim(none)[
  $
    1 * 3 - 1 = 2
  $
]<hoge>
