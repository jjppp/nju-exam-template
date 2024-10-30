#let python = `python`
#let blank_space(width: 22) = [#underline(range(width).map(_ => " ").join(""))]
#let emphasize(content) = [#underline(stroke: (dash: "dotted"), [*#content*])]

#import "@preview/cetz:0.3.1"

#let tree(data) = cetz.canvas({
  import cetz.draw: *
  cetz.tree.tree(
    data,
    direction: "down",
    draw-node: (node, ..) => {
      circle((), radius: .35, fill: white, stroke: 2pt)
      content((), text(black, [#node.content]))
    },
  )
})

#let answer(show_answer, content, score, draw_underline: false) = {
  let content = text(red)[
    *#content*
  ]
  if show_answer {
    [#content #h(1fr) (#score pts)]
  } else if draw_underline {
    [#underline(hide(content)) #h(1fr) (#score pts)]
  } else {
    [#hide(content) #h(1fr) (#score pts)]
  }
}

#let answer_code(show_answer, content) = {
  if show_answer {
    content
  } else {
    "_" * calc.max(content.len(), 10)
  }
}

// Workaround for code blocks with line numbering
#let code_block(show_answer: false, code_string) = {
  let r = regex("#\{\{(.+?)\}\}")
  let text = ""

  for line in code_string.text.split("\n") {
    let matches = line.matches(r)
    let new_line = line
    for occurence in matches {
      let (hidden_answer, score) = occurence.captures.at(0).split("@")
      new_line = new_line.replace(
        occurence.text,
        answer_code(show_answer, hidden_answer),
      ) + " # (" + str(score) + "pts)"
    }
    text += new_line + "\n"
  }

  table(
    columns: (auto, 1fr),
    align: (right, left),
    raw(
      lang: code_string.lang,
      block: true,
      range(1, code_string.text.split("\n").len() + 1).map(str).join("\n"),
    ),
    table.cell(
      breakable: false,
      raw(
        lang: code_string.lang,
        block: true,
        text,
      ),
    ),
  )
}
