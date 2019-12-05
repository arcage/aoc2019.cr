# AoC2019 on Crystal

My solutions for [Advent of Code 2019](https://adventofcode.com/) by using [Crystal language](https://crystal-lang.org/).

Done to day 4.

## Structure

```
- aoc2019.cr/
  - exec/
    - day[DAY]_[PART].cr # source file to solve the specific quiz part.
  - spec/
    - day_spec/
      - day[DAY]_spec.cr # spec file for the quiz of that day
    - aoc2019_spec.cr    # default spec file for AoC2019 module made by crystal
    - spec_helper.cr     # default helper file made by crystal
  - src/
    - aoc2019/
      - day[DAY].cr      # implementation for the quiz of that day
    - aoc2019.cr         # the main source file of AoC2019 module
```

## Test

Test for all days.

```
% crystal spec
```

Test for only one day.

```
$ crystal spec spec/day_spec/day1_spec.cr
```

## Solve Quiz

Give your quiz input to `exec/day[DAY]_[PART].cr` as a text file or STDIN.

```
$ crystal build exec/day1_1.cr
$ ./day1_1 your_quiz_input_of_day1.txt
```

this same as above:

```
$ ./day1_1 < your_quiz_input_of_day1.txt
```
