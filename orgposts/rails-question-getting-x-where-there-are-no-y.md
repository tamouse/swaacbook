
# Table of Contents

1.  [[Rails Question] Getting X where there are no Y](#rails-question-getting-x-where-there-are-no-y)
    1.  [Two Models](#two-models)
    2.  [Associations](#associations)
    3.  [Finding Questions with No Answers:](#finding-questions-with-no-answers)
    4.  [Converse: Finding All Questions that have Answers:](#converse-finding-all-questions-that-have-answers)


<a id="rails-question-getting-x-where-there-are-no-y"></a>

# [Rails Question] Getting X where there are no Y

-   published date: 2015-03-03 05:38
-   keywords: ["code", "examples", "questions", "rails", "ruby"]
-   source: <https://github.com/tamouse/example_questions_without_answers>

There was a question recently in the `#RubyOnRails` IRC channel on [freenode](http://www.freenode.net): "How can I retrieve all the questions that don't have answers?". [This Rails coding example shows the answer](https://github.com/tamouse/example_questions_without_answers).


<a id="two-models"></a>

## Two Models

-   Question
-   Answer


<a id="associations"></a>

## Associations

-   Question *has<sub>many</sub>* Answers
-   Answer *belongs<sub>to</sub>* Question


<a id="finding-questions-with-no-answers"></a>

## Finding Questions with No Answers:

    Question.includes(:answers).where(answers: {id: nil})


<a id="converse-finding-all-questions-that-have-answers"></a>

## Converse: Finding All Questions that have Answers:

    Question.includes(:answers).where.not(answers: {id: nil})

