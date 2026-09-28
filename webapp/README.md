# DETECT v2 webapp

A [NiceGUI](https://nicegui.io/) webapp and command line evaluator over the DETECT v2 SysML v2 models at the root of this repository, using [Syside Automator](https://docs.sensmetry.com/automator/). It covers the three use cases the models declare: ecosystem sizing, tool types by lifecycle phase, and tool types by job series.

The models are the source of truth. Use cases, questions, answers, help text, lifecycle phases, job series, criteria, requirements, their ordering and tool mappings are all read out of the models, so extending DETECT means editing the models rather than the Python.

## Running it

From this directory:

```sh
uv sync
uv run python webapp_main.py      # webapp on $PORT, default 8080
uv run python detect.py           # command line, writes CSVs to Output/
uv run python -m pytest tests/    # tests
```

Both entry points need a Syside Pro licence. For a trial, see [syside.sensmetry.com](https://syside.sensmetry.com).

The evaluator loads every `.sysml` file in `..`, the repository root. Set `DETECT_MODEL_DIR` to load them from somewhere else.

The command line path reads your answers out of the model files themselves: set the sizing attributes in `sizing_input.sysml` away from `TBD`, and set the boolean flags in `lifecycle_phase_input.sysml` and `job_series_input.sysml`. The webapp writes the same answers into an in-memory copy of the model instead, so it leaves the files alone.

## What it produces

| File | Contents |
| --- | --- |
| `requirements.csv` | `id`, `value`, `description` — ecosystem requirements applicable at the calculated size |
| `criteria.csv` | `id`, `value`, `criteria`, `context` — tool evaluation criteria applicable at the calculated size |
| `uc2_tools.csv` | `tool_type`, `required_by` — tool types required by the selected lifecycle phases |
| `uc3_tools.csv` | `tool_type`, `required_by` — tool types required by the selected job series |

The tool type files are named after the use case's short name in the model, so a fourth use case gets its own file without a change to the Python. The `value` column is the weight the model assigns, rounded to four decimal places on output only.

## Layout

- `detect.py` — the evaluator, and the command line entry point. Nothing here reimplements a filtering rule, a weight or a tool mapping; all of it is evaluated from the models.
- `webapp_main.py` — the webapp: a landing page, a configuration page with one tab per use case, tables and CSV downloads.
- `README_web.md` — the text of the landing page.
- `tests/` — tests over the evaluator, run against the models in the repository root.

## Container image

Build from the repository root, so that the models are in the build context:

```sh
docker build -f webapp/Dockerfile -t detect-webapp .
```

Dependencies are managed by [uv](https://docs.astral.sh/uv/): `pyproject.toml` declares them and `uv.lock` pins every package by version and hash. The image installs with `uv sync --frozen`, which fails rather than silently relocking.

The image contains no licence. `SYSIDE_LICENSE_FILE` points at `/secrets/syside-license.lic`, which is expected to be mounted at runtime, for example:

```sh
docker run -p 8080:8080 -v /path/to/syside-license.lic:/secrets/syside-license.lic:ro detect-webapp
```

Do not pass the licence through an `ENV` instruction or a build argument: those are recorded in the image and can be read with `docker history`. `Dockerfile.dockerignore` excludes `*.lic` from the build context for the same reason.
