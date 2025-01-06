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

#let hint(hint) = [
  *Hint: #hint*
]

#let answer(
  show_answer,
  score_state,
  content,
  score,
  draw_underline: false,
) = {
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
  score_state.update(problem_score => problem_score + score)
}

// Workaround for code blocks with line numbering
#let code_block(
  show_answer,
  score_state,
  content,
) = {
  let r = regex("#\{\{(.+?)\}\}")
  let text = ""

  for line in content.text.split("\n") {
    let matches = line.matches(r)
    let new_line = line
    for occurrence in matches {
      let (hidden_answer, score) = occurrence.captures.at(0).split("@")
      let score = int(score)
      new_line = (
        new_line.replace(
          occurrence.text,
          if show_answer {
            hidden_answer
          } else {
            "_" * calc.max(occurrence.text.len(), 10)
          },
        )
          + " # ("
          + str(score)
          + "pts)"
      )
      score_state.update(problem_score => problem_score + score)
    }
    text += new_line + "\n"
  }

  table(
    columns: (auto, 1fr),
    align: (right, left),
    raw(
      lang: content.lang,
      block: true,
      range(1, content.text.split("\n").len() + 1).map(str).join("\n"),
    ),
    table.cell(
      breakable: false,
      raw(
        lang: content.lang,
        block: true,
        text,
      ),
    ),
  )
}
