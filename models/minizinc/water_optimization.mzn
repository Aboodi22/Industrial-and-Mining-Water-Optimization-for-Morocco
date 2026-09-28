% EDI Morocco Water — baseline monthly cost minimization
% All volumes are m3/month. All values are synthetic illustrative assumptions.

int: NS;
int: NU;
int: NT;

set of int: SOURCES = 1..NS;
set of int: USERS = 1..NU;
set of int: MONTHS = 1..NT;

array[SOURCES] of string: source_name;
array[USERS] of string: user_name;
array[MONTHS] of string: month_name;

array[SOURCES, MONTHS] of int: availability;
array[USERS, MONTHS] of int: demand;
array[SOURCES] of int: unit_cost;
array[SOURCES, USERS] of bool: compatible;

int: groundwater_source;
int: recycled_source;
int: wastewater_source;
int: surface_source;

array[MONTHS] of int: groundwater_limit;
array[MONTHS] of int: recycling_limit;
array[MONTHS] of int: wastewater_treatment_limit;

int: storage_capacity;
int: initial_storage;
int: minimum_reserve;
array[MONTHS] of int: storage_inflow;
array[MONTHS] of int: storage_release_limit;
array[MONTHS] of int: discharge_limit;
int: storage_holding_cost;

array[SOURCES, USERS, MONTHS] of var 0..100000: x;
array[MONTHS] of var 0..storage_capacity: storage;
array[MONTHS] of var 0..100000: discharge;

% Demand must be met for every user in every month.
constraint forall(u in USERS, t in MONTHS)(
    sum(s in SOURCES)(x[s,u,t]) = demand[u,t]
);

% Source availability.
constraint forall(s in SOURCES, t in MONTHS)(
    sum(u in USERS)(x[s,u,t]) <= availability[s,t]
);

% Quality/compatibility.
constraint forall(s in SOURCES, u in USERS, t in MONTHS)(
    if compatible[s,u] then true else x[s,u,t] = 0 endif
);

% Groundwater withdrawal limit.
constraint forall(t in MONTHS)(
    sum(u in USERS)(x[groundwater_source,u,t]) <= groundwater_limit[t]
);

% Recycled-water recovery limit.
constraint forall(t in MONTHS)(
    sum(u in USERS)(x[recycled_source,u,t]) <= recycling_limit[t]
);

% Treated wastewater treatment/availability limit.
constraint forall(t in MONTHS)(
    sum(u in USERS)(x[wastewater_source,u,t]) <= wastewater_treatment_limit[t]
);

% Simplified storage balance, independent of direct source allocations.
% A later model version can explicitly route reservoir withdrawals to users.
constraint forall(t in MONTHS)(
    storage[t] =
        (if t = 1 then initial_storage else storage[t-1] endif)
        + storage_inflow[t]
        - discharge[t]
);

constraint forall(t in MONTHS)(
    storage[t] >= minimum_reserve
);

constraint forall(t in MONTHS)(
    sum(u in USERS)(x[surface_source,u,t]) <= storage_release_limit[t]
);

constraint forall(t in MONTHS)(
    discharge[t] <= discharge_limit[t]
);

% Cost objective: source allocation costs plus storage holding cost.
var int: total_cost =
    sum(s in SOURCES, u in USERS, t in MONTHS)(x[s,u,t] * unit_cost[s])
    + sum(t in MONTHS)(storage[t] * storage_holding_cost);

solve minimize total_cost;

output [
    "status: optimal\n",
    "total_cost_mad: ", show(total_cost), "\n",
    "annual_demand_m3: ", show(sum(u in USERS, t in MONTHS)(demand[u,t])), "\n",
    "annual_surface_water_m3: ", show(sum(u in USERS, t in MONTHS)(x[surface_source,u,t])), "\n",
    "annual_groundwater_m3: ", show(sum(u in USERS, t in MONTHS)(x[groundwater_source,u,t])), "\n",
    "annual_recycled_water_m3: ", show(sum(u in USERS, t in MONTHS)(x[recycled_source,u,t])), "\n",
    "annual_treated_wastewater_m3: ", show(sum(u in USERS, t in MONTHS)(x[wastewater_source,u,t])), "\n",
    "annual_discharge_m3: ", show(sum(t in MONTHS)(discharge[t])), "\n",
    "monthly_storage_m3: ", show(storage), "\n",
    "allocations_source_user_month: ", show(x), "\n"
];
