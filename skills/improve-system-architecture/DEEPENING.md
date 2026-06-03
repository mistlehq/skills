# Deepening

Deepening turns shallow modules or scattered workflows into modules with smaller interfaces, stronger locality, and better test surfaces.

## Dependency Categories

Classify dependencies before recommending a seam:

- **In-process**: pure computation or in-memory state. Usually deepenable by consolidating behavior and testing through the new interface.
- **Local-substitutable**: local stand-ins exist, such as an in-memory filesystem or local database substitute. Test through the deep module with the stand-in as an internal implementation detail.
- **Remote owned**: adjacent services or repos owned by the same organization. A cross-repo recommendation may need an explicit port plus production and test adapters.
- **True external**: third-party services or providers. Hide provider details behind a stable module interface when the calling code should not know the provider contract.
- **Fixed contract**: a contract that cannot reasonably change now. Treat it as a constraint; do not pretend a repo-local refactor can fix it.

## Seam Discipline

- Put seams where behavior actually varies or where a system boundary is real.
- Do not expose internal seams just because tests use them.
- Do not add one-adapter indirection and call it architecture.
- If frontend, backend, worker, or provider contracts shape the behavior, identify the system seam before proposing a repo-local module.

## Testing Strategy

- Tests should move toward the interface that callers use.
- Replace brittle shallow-module tests when a deeper module interface can verify the behavior more directly.
- Keep tests focused on observable outcomes, not internal call order or implementation state.
- Flag weak confidence when the current architecture forces tests through internals, over-mocks the system seam, or cannot exercise the behavior without cross-repo fixtures.
