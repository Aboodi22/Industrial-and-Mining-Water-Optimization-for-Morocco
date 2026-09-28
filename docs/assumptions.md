# Assumptions

1. All monthly volumes are in cubic metres (m³/month).
2. All costs are illustrative Moroccan dirhams (MAD) per m³; energy is represented as a cost component in this first model.
3. All operational data are synthetic assumptions, not measured or official Khouribga/OCP data.
4. The planning horizon is January–December, with a cyclic year not assumed: month 1 starts from a specified initial storage.
5. Water is treated as compatible with a user only where the `compatible[source,user]` matrix is true.
6. Recycled process water is modeled as a recoverable supply pool with a monthly cap. It is not double-counted as a new freshwater withdrawal.
7. Treated wastewater is modeled as an externally available source with treatment capacity already reflected in its monthly availability.
8. Storage is a single simplified reservoir. Monthly storage balance is enforced; detailed network hydraulics are out of scope.
9. Demand must be met in this first baseline. Infeasible cases will be diagnosed in later iterations; unmet-demand slack is not yet enabled.
10. Cost minimization is the first objective. Environmental penalties and multi-objective weights are deferred until the baseline is validated.
