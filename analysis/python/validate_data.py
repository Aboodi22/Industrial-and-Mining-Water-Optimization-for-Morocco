#!/usr/bin/env python3
"""Validate the synthetic monthly case using only the Python standard library."""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "data" / "synthetic" / "khouribga_monthly.csv"
NONNEGATIVE = [
    "surface_availability_m3", "groundwater_limit_m3",
    "recycled_availability_m3", "treated_wastewater_availability_m3",
    "phosphate_processing_demand_m3", "mineral_washing_demand_m3",
    "dust_suppression_demand_m3", "general_industrial_demand_m3",
]

with DATA.open(newline="", encoding="utf-8") as f:
    rows = list(csv.DictReader(f))

assert len(rows) == 12, f"Expected 12 months, got {len(rows)}"
assert len({r["month"] for r in rows}) == 12, "Month labels must be unique"
for row in rows:
    for field in NONNEGATIVE:
        value = float(row[field])
        assert value >= 0, f"Negative value: {row['month']} {field}"
        assert value == int(value), f"Expected whole m³ in starter data: {row['month']} {field}"

total_demand = sum(
    int(r["phosphate_processing_demand_m3"])
    + int(r["mineral_washing_demand_m3"])
    + int(r["dust_suppression_demand_m3"])
    + int(r["general_industrial_demand_m3"])
    for r in rows
)
print(f"PASS: {len(rows)} months validated.")
print(f"Annual demand: {total_demand:,} m³")
print("Data status: synthetic assumptions; not official site data.")
