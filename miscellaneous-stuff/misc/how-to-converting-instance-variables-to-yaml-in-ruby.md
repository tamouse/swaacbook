
# Table of Contents

1.  [How to: Converting Instance Variables to YAML in Ruby](#how-to-converting-instance-variables-to-yaml-in-ruby)
    1.  [Introduction](#introduction)


<a id="how-to-converting-instance-variables-to-yaml-in-ruby"></a>

# How to: Converting Instance Variables to YAML in Ruby

-   published date: 2014-11-02 23:51
-   keywords: ["howtos", "instance-variables", "ruby", "swaac"]
-   source: <https://github.com/tamouse/example_converting_instance_variables_to_yaml_in_ruby>

(Reposting from my old [wiki][tamwiki]): On a recent post in ruby-talk, the question was asked how to convert something to `YAML`. Extending this generally to ruby objects, I went searching for something that would work besides a brute-force creation of a Hash.


<a id="introduction"></a>

## Introduction

The original request was to be able to generate the following YAML from a result:

`desired_output.yaml`:

\`\`\` yaml

