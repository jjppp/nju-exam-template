#import "template/exam.typ": exam
#import "problems/wwpd.typ": WWPD
#import "problems/diagram.typ": EnvironmentDiagram
#import "problems/hof.typ": HigherOrderFunction
#import "problems/tree.typ": Tree

#show: exam(
  (
    WWPD,
    EnvironmentDiagram,
    HigherOrderFunction,
    Tree,
  ),
  course_name: (en: "SICP", zh: "计算机程序的构造和解释"),
  year: (from: 2024, to: 2025),
  semester: (en: "Fall", zh: "秋季学期"),
  show_answer: true,
)
