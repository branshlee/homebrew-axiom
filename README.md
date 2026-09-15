# Axiom

Axiom is an experimental intelligence architecture. It receives observations,
discovers executable laws that explain them, tests those laws on evidence it
has not seen, keeps what it cannot explain as residuals, folds its own
theories into reusable operators, and re-expresses older knowledge through
newer, more general representations. Everything it knows is content-addressed
data; the trusted core is a small kernel that only evaluates and verifies.

This repository is the Homebrew tap: prebuilt binaries for macOS (Apple
Silicon) and Linux (x86_64), plus an optional knowledge snapshot. The source
lives in a separate repository.

---

## 1. Install

```bash
brew tap branshlee/axiom
brew trust branshlee/axiom        # Homebrew 6+: third-party taps must be trusted once
brew install axiom                # the program, empty knowledge
brew install axiom-full           # optional: adds a knowledge snapshot to start from
```

One-liner without a prior tap: `brew install branshlee/axiom/axiom`.

Keep it current, remove it:

```bash
axiom version
axiom update                      # latest published version (through Homebrew when installed that way)
axiom uninstall                   # removes the program, keeps ~/.axiom
axiom uninstall --purge           # also removes ~/.axiom, including the store
```

## 2. First run

```bash
axiom init                                              # empty knowledge
axiom init --from "$(brew --prefix axiom-full)/share/axiom-full/knowledge"   # or start from the snapshot
axiom init https://github.com/<you>/axiom-knowledge     # or make your store a clone of your own knowledge repository
axiom                                                   # enter a session
```

`axiom` keeps everything under `~/.axiom` (or `$AXIOM_HOME`):

```text
~/.axiom/
  store/     the content-addressed store: objects/<hh>/<hash> and events.log
             (a git checkout if you gave `init` a URL; `--push` and `sync` use it)
  data/
    worlds/        one file per world: recorded observations, or a hidden law
    experiments/   experiment specs, search and cost configuration
    schemas/       descriptions of every object schema
```

The data directory is seeded on first run from defaults built into the
binary; existing files are never overwritten.

## 3. The session

Typing `axiom` opens a session over one store. Commands:

| command | what it does |
|---|---|
| `status` | rounds so far, library entries, promoted theories, each world's status |
| `evolve [N] [spec\|all]` | run N rounds (default 1) of a spec; `all` (default) puts every world in `data/worlds` in play |
| `worlds` | list the worlds in play |
| `import <csv> <name> [held-out]` | turn a CSV into a recorded world (last `held-out` rows reserved for testing, default 6) |
| `observe <world> <x…> <y>` | hand the system one observation; creates the world if needed |
| `holdout <world> <K>` | reserve the last K observations of a recorded world for testing predictions |
| `propose <world> <term>` | offer a candidate law, e.g. `propose mine (+ (* 2 x) 1)`; it is verified, never trusted |
| `ask <world>` | which input would best separate the theories that currently fit |
| `experiment <name>` | run one of the fixed experiments (`linear`, `falsification`, `metafold`) |
| `events [N]` | the last N events (default 20) |
| `why <id> [depth]` | provenance walk from any object down to the evidence |
| `show <id>` | render any stored object |
| `merge <store-dir \| git-url>` | bring in another instance's knowledge |
| `sync` | commit and push the store to its git remote |
| `version`, `update` | this binary |
| `help`, `quit` | |

Every command also exists as `axiom <command> …` from the shell, with
`--store DIR` and `--data DIR` to point elsewhere. Shell-only extras:

```bash
axiom evolve --all --rounds 30 --push        # push after the run
axiom evolve --all --json                    # one JSON object per round, for programs
axiom status --json
axiom watch                                  # live tail of the event log
axiom demo                                   # the whole loop, narrated, in one run
```

## 4. Feeding it data

A recorded world is a table of observations. Give it a CSV with any number
of input columns and one output column; a header names the variables:

```csv
x,y
0,1
1,3
2,5
```

```csv
a,b,y
1,2,3
2,3,7
```

Values may be integers, `true`/`false`, or rationals written `p/q`. Then:

```bash
axiom import measurements.csv mine 6      # last 6 rows held out for testing
axiom evolve --rounds 20
```

Or interactively, one observation at a time: `observe mine 3 7`, then
`holdout mine 3`. A world with no held-out observations can never promote a
theory: a law that was not tested on unseen evidence is not accepted.

World files are s-expressions in `data/worlds/`; you can also write one by
hand, including a hidden law for a synthetic world:

```lisp
{:name linear
 :variable x
 :law (+ (* 2 x) 1)
 :synthesis (-3 -1 0 1 2 4)
 :held_out (-10 3 7 25)}
```

## 5. What a round does

Each `evolve` round, the system:

1. chooses a world (in spec order, or by expected compression when the spec
   sets `:world_probe`);
2. gathers evidence: the world's synthesis observations, or, with an
   `:inquiry` section in the spec, a seed observation followed by questions
   chosen to separate the theories that still fit;
3. searches for the cheapest law over the primitives plus its library of
   certified operators (cost-ordered enumeration; the library makes search
   cheaper, not just theories);
4. predicts the held-out observations *before* the world answers, then
   compares; every mismatch becomes a residual object;
5. promotes the theory only if it predicted every held-out point and is
   cheaper than leaving the evidence unexplained;
6. re-expresses earlier theories through the library when a cheaper,
   observationally equivalent form exists (certified);
7. folds structurally similar theories into generalizations; a
   generalization that compresses enters the library as an operator;
8. folds the library itself: a more general entry replaces the entries it
   subsumes, with reconstruction certificates;
9. records the round, the policy it ran under, and every object it created.

Nothing is ever deleted or rewritten. A falsified theory, its residuals and
the evidence all remain; a newer theory `supersedes` an older one.

## 6. Reading what it knows

```bash
axiom status
axiom events 40
axiom why b3:<id> 4          # any theory, certificate, residual, round, merge…
axiom show b3:<id>
```

Object ids are BLAKE3 hashes of canonical bytes, so the same law discovered
by two instances has the same id.

## 7. Sharing knowledge

Each instance has its own history. To publish yours:

```bash
axiom init https://github.com/<you>/axiom-knowledge    # store becomes a clone of your repository
axiom evolve --all --rounds 30 --push                  # or: axiom sync
```

To combine two instances:

```bash
axiom merge ../other-store            # or a git url
```

Objects are unioned (content addressing: no conflicts), the library and
promoted theories are re-derived by folding both sides together, and the
other instance's rounds are kept as referenced objects rather than spliced
into your history.

## 8. Experiment specs

`data/experiments/*.sexp` define what a run does. The useful knobs:

```lisp
{:name mine
 :kind evolve
 :worlds (mine other)             ; or use `evolve --all`
 :search common-search            ; operators, constants, cost budget
 :cost_model common-cost          ; residual overhead, reference cost, variable cost, tolerance
 :lambda 1
 :expect promoted
 :world_probe 2                   ; optional: choose worlds by expected compression
 :inquiry {:seed 1 :max_queries 6 :margin 8 :query_range (-12 12)}   ; optional: active inquiry
 :promotion {:require_held_out_zero true :require_below_baseline true}}
```

A cost model with `:tolerance 1` accepts integer predictions within ±1
(for noisy data). Every rule parameter a run consults is stored as an
`axiom/policy` object and referenced from each round.

## 9. Limits, honestly

Values are integers (booleans and rationals as derived data); noise is an
integer tolerance; search over recursive laws is expensive, and primality
is still an open benchmark; the rules of the loop are data-parameterised
but their bodies are code. The primitive set is sealed: every further
operator must be one the system folded out of its own theories.
