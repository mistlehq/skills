# Language

Use this architecture vocabulary consistently in recommendations. Preserve established repo and domain names when they are real local terms.

## Terms

- **Module**: anything with an interface and implementation, at any scale: function, class, package, feature slice, repo, or service.
- **Interface**: everything a caller must know to use a module correctly, including types, invariants, ordering, error modes, config, and performance expectations.
- **Implementation**: code or behavior hidden inside a module.
- **Depth**: leverage at the interface. A deep module provides substantial behavior behind a small interface. A shallow module has an interface nearly as complex as its implementation.
- **Seam**: a place where behavior can change without editing the caller. The interface lives at the seam.
- **Adapter**: a concrete implementation that satisfies an interface at a seam.
- **Leverage**: capability callers get per unit of interface they must learn.
- **Locality**: concentration of change, bugs, knowledge, and verification in one place.

## Principles

- **Deletion test**: imagine deleting the module. If complexity vanishes, it was probably pass-through. If complexity reappears across callers, it was earning its keep.
- **The interface is the test surface**: tests should verify behavior through the interface callers use.
- **One adapter means a hypothetical seam. Two adapters means a real seam**: do not introduce a seam unless something actually varies across it.
- **Depth is not line count**: a deep module may have small implementation if the interface gives callers high leverage.

Use "module", "interface", "implementation", "depth", "deep", "shallow", "seam", "adapter", "leverage", and "locality" for architecture claims. Do not replace established domain terms just to satisfy this vocabulary.
