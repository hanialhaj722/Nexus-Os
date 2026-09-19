# NEXUS — AI Quant & Market Intelligence OS

Paper-first operating system for market intelligence, quantitative research, and governed paper trading.  
**It does not guarantee profits.** Accuracy claims are forbidden until journaled, out-of-sample, and paper-forward evidence exists.

Company brand: **NEXUS**. Visual system: Cyberpunk Gold & Dark Emerald on Deep Obsidian (`#0B0E14`, `#F0B90B`, `#10B981`, `#06B6D4`, `#EF4444`).

## What this founding phase includes

- Clean architecture (API → services → domain → infrastructure)
- FastAPI + WebSocket quote hub
- Deterministic **Risk Engine** and **Kill Switch** (AI cannot override)
- **Paper trading only** — no payment gateways, no bank linking, live execution hard-disabled
- Multi-broker **unified connector layer** (MT4/5, cTrader, IBKR, Rithmic, Tradovate, CCXT crypto, TradingView webhooks)
- Backtest engine with next-bar execution, cost model, walk-forward, survivorship hooks
- AI Investment Committee + CIO synthesis, Prediction Journal, Forecast Calibration
- Owner Admin Portal vs subscriber RBAC
- Hash-chained audit log + `.env` secret isolation
- PostgreSQL / TimescaleDB / Redis / Neo4j schemas
- Flutter client (web + iOS + Android) with glassmorphic Command Center

## Quick start

```bash
cp .env.example .env
# set SECRET_KEY and database passwords
docker compose up --build
```

API: `http://localhost:8000/health`  
OpenAPI: `http://localhost:8000/docs`

Local API without Docker (Postgres optional for the in-memory bootstrap):

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
set SECRET_KEY=dev-secret-key-please-change-32
python -m uvicorn app.main:app --reload --port 8000
```

Flutter:

```bash
cd flutter_app
flutter run -d chrome
```

Bootstrap users (from `.env`):

| Email | Role |
|---|---|
| `OWNER_EMAIL` (default `owner@nexus.local`) | owner |
| `demo@nexus.local` / `subscriber-demo` | subscriber |

## Mapping to the product documents

The attached feature and pain-point PDFs are encoded as modules, not slogans:

| Document pillar | Code |
|---|---|
| Macro / regime / command center | `services/intelligence.py`, Flutter Command Center |
| Equity, valuation, news, technicals | Intelligence hub with `DATA UNAVAILABLE` (zero hallucination) |
| Quant lab, factors, ensemble | `engines/quant.py` |
| Forecasts, committee, CIO | `agents/committee.py` |
| Backtest, PIT, walk-forward | `engines/backtest.py` |
| Prediction journal + calibration | `services/journal.py`, `engines/calibration.py` |
| Risk, VaR/CVaR, Kill Switch | `engines/risk.py` |
| Paper trading | `engines/paper.py` |
| Knowledge graph | `infra/neo4j/init.cypher` |
| Governance, RBAC, audit, model registry | `core/rbac.py`, `core/audit.py`, `infra/postgres/init.sql` |

## Hard rules

1. LLM output is research only. Orders go through `RiskEngine` then `PaperBroker`.
2. Missing data returns **DATA UNAVAILABLE** — numbers are never invented.
3. Predictions lock **before** outcomes.
4. Secrets never leave `.env` / server memory; Flutter never receives API keys.
5. Subscribers cannot call owner routes (`/api/v1/owner/*`) or connector internals.

## Tests

```bash
cd backend
pip install -r requirements.txt
pytest -q
```
