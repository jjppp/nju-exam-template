#import "common.typ": *

#let exam(
  course_name: (
    en: "English Course",
    zh: "中文课程",
  ),
  exam_type: (
    en: "midterm",
    zh: "期中考试",
  ),
  instructors: ("Mable", "Dipper"),
  year: (from: 2024, to: 2025),
  semester: (en: "Fall", zh: "秋季学期"),
  show_answer: false,
  problems,
) = [
  #set page(numbering: "1 / 1")
  #set text(
    font: "Times New Roman",
    size: 11pt,
  )
  #set raw(theme: "default.tmTheme")
  #let problems = problems.map(x => x(show_answer: show_answer))
  #let total_score = problems.map(x => x.score).sum()

  #align(
    center,
    text(17pt)[
      《#course_name.zh》#exam_type.zh
    ],
  )
  #align(
    center,
    text(15pt)[
      （#year.from - #year.to #semester.zh，授课教师：#instructors.join("，")）
    ],
  )
  #align(center)[
    学号：#blank_space()，
    姓名：#blank_space()，
    院系：#blank_space()，
    得分：#blank_space(width: 10)
    （满分：#total_score）
  ]

  #table(
    columns: (auto,) + problems.len() * (1fr,),
    table.header(
      [题目],
      ..(problems.map(x => x.id)),
    ),
    [得分], ..(problems.map(_ => " ")),
  )

  #let python_builtins = (
    `all`,
    `any`,
    `bool`,
    `dict`,
    `enumerate`,
    `filter`,
    `float`,
    `int`,
    `iter`,
    `len`,
    `list`,
    `map`,
    `max`,
    `min`,
    `pow`,
    `print`,
    `range`,
    `reversed`,
    `round`,
    `sorted`,
    `sum`,
    `zip`,
  )

  注意事项：
  + 试题的难度不是线性递增的，#emphasize([注意时间分配])。在这项测验中，可能有些题目较难，因此你不要在一道题上思考太久，遇到不会答的题目可先跳过，如果有时间再去思考。否则，你可能没有时间完成后面的题目。
  + 代码填空题的#emphasize([正确答案不止一种])。代码填空题答案正确即可得分，错误也不会倒扣分。每空#emphasize([最多只能填一个]) Python 语句或表达式，可以直接使用的 Python 内置函数（Python Built-in Functions）包括
    #python_builtins.join("，", last: " 和 ")。

  #for problem in problems {
    [= #problem.id #problem.title (#problem.score pts)]
    [ \ ]
    [#problem.content]
    pagebreak()
  }
]
