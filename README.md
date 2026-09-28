# EDI Morocco Water

**Industrial and Mining Water Optimization for Morocco**

A transparent, reproducible decision-support MVP for a **simulated phosphate-processing facility inspired by the Khouribga region**. It is not an official model of OCP or any real facility, and its synthetic operational data must not be treated as observed site data.

## First result

The first runnable result is a 12-month MiniZinc linear optimization model. It allocates water from surface water, groundwater, recycled process water, and treated wastewater to four industrial users. It minimizes total modeled cost while meeting demand when feasible, respecting source limits, monthly storage balance, treatment/recycling capacity, groundwater limits, and discharge limits.

## Requirements

- MiniZinc (with a solver such as Gecode)
- Python 3.10+ (standard library only for the starter validation script)
- Go 1.22+ (API scaffold)
- .NET 8 SDK (client scaffold)

Only MiniZinc and Python are needed for the first optimization result.

## Run the first optimization

From the repository root:

```bash
python analysis/python/validate_data.py
minizinc --solver gecode models/minizinc/water_optimization.mzn models/minizinc/examples/khouribga_baseline.dzn
```

If `minizinc` is not on PATH, open the `.mzn` file in MiniZinc IDE and run it with the `khouribga_baseline.dzn` data file.

The data are synthetic assumptions for software demonstration. They are not official water availability, groundwater permits, OCP data, or measured plant demand.

## Project layout

- `data/synthetic/`: reproducible synthetic monthly data
- `data/metadata/`: provenance declaration
- `models/minizinc/`: optimization model and example input
- `analysis/python/`: validation and later analysis scripts
- `services/go-api/`: API scaffold
- `clients/csharp-client/`: client scaffold
- `docs/`: scope, assumptions, model, validation
