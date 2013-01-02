---
title: Data Structures for Range-Sum Queries
type: post
layout: post
date: July 10, 2010
---
This week I attended the <a href="http://cumc.math.ca/2010/en/">Canadian Undergraduate Mathematics Conference</a>. I enjoyed talks from a number of branches of mathematics, and gave a talk of my own on range-sum queries. Essentially, range-aggregate queries are a class of database queries which involve taking an aggregate (in SQL terms, `SUM`, `AVG`, `COUNT`, `MIN`, etc.) over a set of data where the elements are filtered by simple inequality operators (in SQL terms, `WHERE colname {<, <=, =, >=, >} value AND …`). Range-sum queries are the subset of those queries where `SUM` is the aggregation function.

Due to the nature of the conference, I did my best to make things as accessible to someone with a general mathematics background rather than assuming familiarity with databases or order notation.

I’ve put <a href="http://github.com/paulgb/cumc2010/blob/master/slides.pdf">the slides</a> (pdf link) online. They may be hard to follow as slides, but I hope they pique your interest enough to check out the papers referenced at the end if that’s the sort of thing that interests you. I may turn them into a blog post at some point. The presentation begins with tabular data and shows some of the insights that led to the Dynamic Data Cube, which is a clever data structure for answering range-sum queries.

