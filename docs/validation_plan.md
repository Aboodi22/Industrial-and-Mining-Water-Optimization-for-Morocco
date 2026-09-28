# Validation plan

Initial checks:
- Data dimensions and nonnegative values.
- Monthly demand and source capacity units.
- Compatibility matrix dimensions.
- MiniZinc model parses and solves with the example data.
- Recompute demand totals and objective from solver output.
- Later: test infeasible demand, zero sources, storage bounds, and invalid input.
