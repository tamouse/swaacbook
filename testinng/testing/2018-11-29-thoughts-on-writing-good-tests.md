# Thoughts on Testing

* published date: 2018-11-29

Someone asked this question on the WWCodeTC \#learning-to-code Slack channel the other day:

> OP: I asked this in another group and I got a million answers but I'll ask here: anyone have a good way to learn how to write good tests? I've listened to a test driven development course on lynda.com. I don't really have a specific question per se, just looking for a pointer to good testing practices beyond the basics.

My response:

> everyone says testing is Super Important, but no one seems to definitively answer that question. the obvious answer is "write a lot of bad tests" but that is oh so dismal.
>
> the stuff i learned from, ages and ages ago, is probably no longer in print, but look for these authors:
>
> * jerry weinberg
> * boris beizer
> * larry constantine
> * glen meyers
> * bob grady
>
> I met and worked these guys aeons ago, all really amazing authors
>
> look up software quality institute, I'm not sure if it's still going
>
> most all classes and tutorials i see are about how to write tests in a framework, which is good, but like most software education, never really gets at how to do design of software for a purpose and tests do need to fit a purpose
>
> I'll just throw out a few questions you may want to try on as heuristics:
>
> * what are the most critical actions or features users need to function impeccably
> * what features are showing the most failures in use
> * if a feature is unclear in how to use, how many ways can it be used or abused
> * how can i break this?
>
> another way to approach it is from the test driven side, and write tests that describe exactly what the feature does, does not do, responds to random input, responds to incorrect input, etc, so you completely spec the feature before any feature code is written.

I completely left off the intrepid and amazing [Kent C. Dodds](https://kentcdodds.com), author, teacher, developer, tester, and generally all-around nice guy. I do mention him a fair bit in the [learning](../../learning/intro/web-sites/) section.

* keywords: testing, learning

