---
applyTo: "**/*.py,**/pyproject.toml,**/requirements*.txt"
---

# Python instructions

- Inspect pyproject.toml, dependency files, test configuration, and existing code patterns before editing.
- Follow the repository's existing Python version, package manager, formatter, linter, type checker, and test framework.
- Preserve the project's existing typing conventions; add type annotations to new or changed public interfaces when consistent with the codebase.
- Prefer clear, idiomatic Python and small focused functions over unnecessary abstractions.
- Handle errors explicitly; do not silently catch broad exceptions unless existing conventions require it.
- Do not introduce dependencies or change dependency versions unless necessary for the request.

## Performance and concurrency

- Prioritize correctness and readability; optimize only for an identified bottleneck, an explicit requirement, or a clearly unbounded workload.
- Avoid repeated I/O, database queries, network calls, or expensive computations inside loops when results can be reused or fetched in batches.
- Prefer streaming or generators when processing large inputs and materializing all results is unnecessary.
- Use concurrency only for independent work. Bound concurrency, preserve error handling, and avoid blocking the event loop in async code.
- Measure or profile meaningful performance changes when practical; do not claim an improvement without evidence.

## Validation

- Add or update focused tests for behavior changes, including relevant failure cases.
- Run the repository's configured formatting, linting, type-checking, and tests when available.
- Do not log secrets, tokens, passwords, or sensitive personal data.
