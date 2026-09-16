# Changelog

## 0.1.28
### Changed
- One law of persistence. The `promotion` rule decides alone whether a
  theory is kept; the default is now "it compresses all the evidence it
  was shown, mispredictions charged as corrections", and zero held-out
  error is the special case where the corrections cost nothing. The
  `partial` status and hook are gone: a kept theory with residuals is
  `promoted` with its residual count (shown in `status`), is retried
  when the library changes, and leaves a residual world like any other.
- Derivation depth is no longer a number by default: `:max_derivation_depth
  unbounded` in `evolve-base`. A residual is a new question only if the
  theory subtracts something; a theory that subtracts nothing ends the
  chain. Views and non-numeric worlds are never derived.
- Theories of one shape (equal up to literals) always form a fold group
  of their own; greedy grouping newest-first could bury the fold that
  compresses inside a wider one that does not.

## 0.1.27
### Changed
- View projections are data. A `:view` names the events whose subjects
  are its rows (`:events promoted`) and gives `:input`, `:output` and
  `:key` as projection expressions over the subject (`subject`,
  `(field E name…)`, `(term E)`, `(expanded E)`, `(shape E)`,
  `(evidence E)`, `(world E)`, `(count E)`); the three built-in
  collections are gone. `:variable` names the world's variable.
- Candidate rules for `improve` come from the same enumerator that
  proposes theories, over the alphabet in
  `data/experiments/rule-search.sexp`; the two-level boolean grammar in
  code is gone.
- Improving the rules is a task: `improve:<spec>` is discovered every
  `:every` rounds of the rule-search spec (default 100; `:improve` in an
  experiment spec names it, `policy-search` by default when that file
  exists), tried and recorded like any task (`policy-tried` event,
  adoption as before). `axiom improve` remains as a manual trigger.

## 0.1.26
### Changed
- The built-in analogy, library-first and mutate members are gone from
  the code. They are seed proposer programs in `data/proposers/*.sexp`
  (stored once with `by: seed`), written as terms over the environment a
  proposer program sees: `evidence`, `precedents` (shapes of promoted
  theories), `library` (each certified operator applied to holes),
  `near_misses` (shapes of earlier near misses for this world). A
  program may return one shape or a sequence of shapes; the verifier
  fits and judges each. Enumeration is the one member that stays
  mechanism. Default `program_proposers` is 6.

## 0.1.25
### Changed
- The pipeline is gone. A unit of work is a task discovered in the store:
  explain a world, fold a coherent group, re-represent a theory through
  the library, compact the library, derive a residual world, compose a
  solved residual with its parent. Each is claimed, done and recorded
  (`axiom/task` objects with the state before and after) by whichever
  worker takes it; which task goes first is the policy rule `task_score`
  over (gain, kind), default `gain`. `evolve --rounds N` now runs N units
  of work of any kind; rounds are the explain tasks. Merges keep working
  on old and new histories alike.
- A worker that loses a claim race looks again at once instead of
  counting it as nothing to do; the file store tolerates two workers
  writing the same object at the same time.
- Rounds record `synthesis_residuals` (what derive tasks look at).

## 0.1.24
### Added
- Any object set is a world: a world file may carry a `:view` naming a
  collection of stored objects (`promotions`, `rounds`, `proposals`), an
  input field and an output field. The view is read from the store when
  the world is loaded, so it grows as the system works; a view that grew
  by a held-out set's worth is claimable again. Non-scalar outputs are
  named `s1, s2, …` for the search. `axiom view <name>` prints a view's
  rows and symbol table.
- The bundled `proposer-shapes` view: the system's own promotions as
  evidence -> winning shape. A promoted law of a `:role proposer` view is
  registered as a proposer program (`induced:<world>`), or linked to the
  stored proposer it rediscovered (`law-as-proposer` event).
- Rounds record `evidence_count`; view worlds may name their own search
  config (`:search`).

## 0.1.23
### Added
- Workers instead of rounds: `axiom work [--workers N] [--all | --spec S]`
  runs N workers on one store. A worker claims a world with a `claimed`
  event (a lease, no global clock), does one unit of work, records it and
  looks again; other workers' live claims are skipped, a claim that lost
  the race is `released`, and a worker stops when nothing is claimable and
  nobody holds a claim. Several processes on one store behave like
  several threads. `status` lists claims being worked on.
### Changed
- The current state (library, promoted theories) is derived from every
  round's delta (`library_before`/`library_after`, new `promoted_before`),
  not from the last round, so rounds recorded side by side all count.
  Rounds from older versions are read as before.
- Rounds record `worker`. The event log is appended one line per write so
  concurrent appenders never interleave.

## 0.1.22
### Added
- Proposers as data: a proposer is a term (`axiom/proposer`) evaluated
  over the evidence and the precedents; it returns a shape (symbols and
  lists, `?a` holes, `@id` library references) that the verifier decodes,
  fits and judges like any candidate. Every promotion leaves a template
  proposer; templates anti-unify into folded proposers with parents
  recorded; the best by credit run as team members (`program:<name>` in
  the credit table; knob `program_proposers`, default 4). On the
  evolve-team worlds the stored proposers won 8 of 11 promotions and
  displaced the hand-written analogy member entirely.
### Changed
- The credit table names every member by its signature, so stored
  proposers appear beside the built-in kinds.

## 0.1.21
### Added
- Graded verdicts: a mispredicting theory whose corrections are cheap to
  record gets the `partial` status (rule `:partial` in the policy).
- The proposer team (`:team true` in a spec): enumerate, analogy,
  library-first and mutate run in parallel on the same evidence; every
  candidate is stored as a signed `axiom/proposal`; one verifier judges;
  credit per kind appears in `status`. Analogy takes over as soon as a
  precedent exists, library-first as soon as the library does.

## 0.1.20
### Added
- Data sources: `data/sources.sexp` lists directories of CSV files, URLs
  and programs; `axiom ingest` imports whatever is new or changed (by
  content hash, never twice); `axiom run [--every S] [--rounds N] [--push]`
  ingests, evolves and publishes, and keeps doing so on a schedule.
  Ingested worlds are worked on before bundled examples. Each import is
  an `axiom/ingest` object.

## 0.1.19
### Added
- Names: `axiom name <id> <text>` gives any object a name (an
  `axiom/name` object; latest wins). Library entries are named by the
  system when admitted ("operator folded from mod-3, mod-4, mod-5").
- Explanations: `axiom explain <id>` renders a theory or term as a
  sentence using variable names, operator words and library names;
  `status` shows one for every library entry and theory. `AXIOM_LANG=zh`
  switches the wording to Chinese.

## 0.1.18
### Added
- Symbols and sequences in the value domain: `'red`, `nil`, `(a b c)`;
  CSV cells `red` and `a b c`. One new kernel primitive, `fold`
  (structural recursion over a sequence, total). Symbols seen in evidence
  join the search alphabet; a symbol is charged `:symbol_cost`.
- Sequence worlds and experiments: length, reverse, last, count, first.
### Fixed
- Sequence values are written to world files as plain lists and read back
  identically (they were being re-wrapped on load).

## 0.1.17
### Added
- `sync` (and every `--push`) reconciles with the remote first when the
  remote has history this checkout lacks: the remote store's knowledge is
  merged in (objects unioned, state re-derived, a merge object recording
  its rounds), the event logs are combined (theirs first, then ours
  without the shared prefix), and the commit is placed on top of the
  remote head. Two instances that grew apart can publish to one
  repository without conflicts and without losing either history.

## 0.1.16
### Fixed
- `sync` reports a missing remote before looking for changes, so it never
  says "nothing new to publish" when nothing could have been published.

## 0.1.15
### Added
- `--push` on `improve` and `merge`, like `evolve`.
### Fixed
- `sync` explains what to do when the store has no git remote, instead of
  failing inside git; the first push sets the upstream.
- 0.1.14 was published without these changes (tagged before the commit
  landed); 0.1.15 carries them.

## 0.1.13
### Fixed
- `axiom why <id> N` (positional depth, as in the session) is accepted in
  the shell form too; previously only `--depth N` was.

Each version lists what changed for someone running `axiom`. Kernel changes
are called out separately because the kernel is the trusted part.

## 0.1.12
### Added
- `axiom changelog`: what the latest published version changed.
- `axiom update` shows the notes for the version it is about to install.
- Release notes are published with every tap release, from this file.

## 0.1.11
### Fixed
- Residual worlds were derived from every falsified world every round,
  producing chains such as `divisors~1~1`. A residual world is now derived
  only when the theory explained its synthesis evidence and failed on
  unseen points, at most one per world, and not from residual worlds by
  default. (0.1.10 was tagged before this change landed.)

## 0.1.9
### Fixed
- Installed binaries since 0.1.7 could not run `evolve` in a fresh home:
  the bundled default data was a hand-maintained list and lacked
  `policy-default.sexp`. The list is now generated at build time.

## 0.1.8
### Added
- Boolean rules in the policy search use a two-level grammar (integer
  expressions, comparisons, and/or/not to depth 2).
- Policies may carry `inquiry_seed` and `inquiry_margin` knobs; trials
  charge gathered evidence (`:evidence_cost`); `axiom improve <spec>`.
- Worlds implemented by external programs (`:command`); `import` from URLs.
- After a falsified inquiry round, a passive pass over the full synthesis
  set runs before giving up.
### Fixed
- Policy trials no longer write derived-world files outside their scratch
  store.
### Result
- The policy search adopted its first change (`inquiry_margin = 0`) on a
  priced-evidence spec; the prime benchmark remains open.

## 0.1.7
### Added
- Rules as data: promotion, library admission and world scoring are terms
  evaluated by the kernel; `data/experiments/policy-default.sexp`; every
  round names the policy it ran under.
- `axiom improve`: candidate rules are enumerated, tried in scratch runs,
  scored from verifier facts only, re-checked on held-out worlds.
- Worlds derived from residuals; solving one composes a theory that
  explains the parent.

## 0.1.6
### Added
- `axiom merge <store | git-url>`: object union, state re-derived by
  folding both libraries, the other instance's rounds referenced.

## 0.1.5
### Fixed
- `uninstall` resolved the Homebrew symlink and removed only the link.
- Fresh `brew tap` failed the syntax check: the formula lacked a top-level
  `url`.

## 0.1.4
### Fixed
- `version`, `update` and `uninstall` were listed but not dispatched.

## 0.1.3
### Added
- `axiom version`, `axiom update`, `axiom uninstall [--purge]`.

## 0.1.2
### Fixed
- Rounds written by earlier versions failed to load (`missing field
  "choice"`); fields added after the first release are optional on read.

## 0.1.1
### Added
- `axiom init --from <snapshot>`; Homebrew tap with `axiom` and
  `axiom-full`.

## 0.1.0
First release: content-addressed store, sealed term calculus with `rec`
and pairs, cost-ordered search with observational-equivalence pruning,
folding with reconstruction certificates, library of derived operators,
re-representation, library compaction, active inquiry, world choice,
multi-variable worlds, tolerance, interactive session, knowledge
repository publishing.
