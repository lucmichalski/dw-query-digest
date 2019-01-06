# dw-query-digest

Alternative to `pt-query-digest`.

[![Build Status](https://travis-ci.org/devops-works/dw-query-digest.svg?branch=master)](https://travis-ci.org/devops-works/dw-query-digest)

# Purpose

`dw-query-digest` reads slow query logs files and extracts a number of
statistics. It can list top queries sorted by specific metrics.

It is reasonably fast and can process ~450k slow-log lines per second.

A 470MB slow query log containing ~10M lines took ~150s with `pt-query-digest`
and ~23s with `dw-query-digest` (~ 6x faster).

`dw-query-digest` normalizes SQL queries so identical queries can be aggregated
in a report.

# Usage

`bin/dw-query-digest [options] <file>`

## Options

- `--debug`: show debugging information; this is very verbose, and meant for debugging
- `--progress`: display a progress bar
- `--quiet`: display only the report (no log)
- `--reverse`: reverse sort (i.e. lowest first)
- `--sort <string>`: Sort key
  - `time` (default): sort by cumulative execution time
  - `count`: sort by query count
  - `bytes`: sort by query bytes size
  - `lock[time]`: sort by lock time (`lock` & `locktime` are synonyms)
  - `[rows]sent`: sort by rows sent (`sent` and `rowssent` are synonyms)
  - `[rows]examined`: sort by rows examined
  - `[rows]affected`: sort by rows affected
- `--top <int>`: Top queries to display (default 20)
- `--version`: Show version & exit

# Caveats

Some corners have been cut regarding query normalization. So YMMV regarding
aggregations.

# Contributing

If you spot something missing, or have a slow query log that is not parsed
correctly, please open an issue and attach the log file.

Comments, criticisms, issues & pull requests welcome.

# Licence

MIT