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
  course_name: "计算机程序的构造和解释",
  course_year: 2024,
  show_answer: true,
)
