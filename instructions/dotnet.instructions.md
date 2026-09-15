---
applyTo: "**/*.cs,**/*.csproj,**/*.sln,**/Directory.Build.props,**/Directory.Packages.props,**/appsettings*.json"
---

# .NET instructions

- Inspect the solution structure, target frameworks, package-management configuration, and existing project patterns before editing.
- Follow existing conventions for nullable reference types, analyzers, dependency injection, logging, error handling, and configuration.
- Preserve public API compatibility unless a breaking change is explicitly requested.
- Use asynchronous APIs consistently with the existing codebase; pass CancellationToken through I/O-bound application flows when the surrounding code supports it.
- Do not add NuGet packages or change package versions unless necessary for the request.
- Do not place secrets, connection strings, tokens, or production settings in source-controlled configuration files.
- For data-model or schema changes, identify migration, backwards-compatibility, and rollout implications before editing.

## Performance and concurrency

- Prioritize correctness and readability; optimize only for an identified bottleneck, an explicit requirement, or a clearly unbounded workload.
- Avoid unnecessary repeated enumeration, materialization, allocations, database round trips, and network calls in hot paths.
- Use Task.WhenAll or parallel execution only for independent operations; bound concurrency for large collections and preserve cancellation and error handling.
- Do not block asynchronous code with .Result, .Wait(), or synchronous I/O when an established asynchronous path exists.
- Measure or profile meaningful performance changes when practical; do not claim an improvement without evidence.

## Validation

- Add or update focused tests using the repository's existing test framework and patterns.
- Run dotnet build and the relevant test suite when available.
