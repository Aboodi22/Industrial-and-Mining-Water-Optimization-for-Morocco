# Mathematical model — baseline

## Sets
- `S`: four sources (surface, groundwater, recycled process water, treated wastewater)
- `U`: four users (phosphate processing, washing/enrichment, dust suppression, general industrial)
- `T`: 12 months

## Decision variables
- `x[s,u,t] >= 0`: water volume from source `s` to user `u` in month `t`
- `storage[t] >= 0`: end-of-month storage
- `discharge[t] >= 0`: monthly discharge

## Objective
Minimize the sum of source-specific unit costs multiplied by allocated volumes, plus a small storage holding cost. Costs are illustrative.

## Constraints
1. Demand satisfaction for every user/month.
2. Monthly availability limits for each source.
3. Source-to-user quality compatibility.
4. Groundwater monthly limit.
5. Storage balance, capacity and minimum reserve.
6. Storage release cannot exceed available stored volume plus current surface-water inflow.
7. Recycled-water allocation cannot exceed recoverable monthly process water.
8. Treated-wastewater allocation cannot exceed monthly treatment/availability capacity.
9. Discharge remains under its monthly cap.

## Limitation
The first model is a deterministic linear program. It does not model detailed process chemistry, aquifer dynamics, reservoir hydrology, or actual legal permits.
