# AoC2019 on Crystal

My solutions for [Advent of Code 2019](https://adventofcode.com/) by using [Crystal language](https://crystal-lang.org/).

Done till day 5.

## Structure

```
- aoc2019.cr/
  - exec/
    - day[DAY]_[PART].cr # source file to solve the specific quiz part.
    - day5.cr            # Both of part 1 and 2 in Day 5. 
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

Sorry, the spec file for day 5 was not produced.

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

_NOTE: Day 5 have only one source file to solve quiz and take no commandline paramerters. Part 1 and 2 will be identified by the input value, - `1` for part 1, `5` for part2._

