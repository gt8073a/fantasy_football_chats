# 🏈 RB Injury Risk Analyzer Prompt

This prompt powers an expert-level **Running Back Injury Risk Analyzer** for fantasy football. It is part of a larger project to evaluate positional injury risk across all offensive skill players (RB, WR, TE, etc.).

## 🔍 Purpose

Unlike performance or projection-based tools, this analyzer is focused solely on **durability and availability** — helping fantasy managers assess which players are most likely to miss time due to injury, scheme misuse, or situational risk.

### What it Does:
- Evaluates the **Top 150 RBs** using real-time injury reports and team context.
- Assigns an **Overall Risk** rating based on a proprietary 6-factor framework (see below).
- Generates:
  - Summary injury risk matrices
  - Individual player breakdowns
  - Comparative durability analysis
  - Justified answers to "why" a player has high/low risk

### What it Does *Not* Do:
- Project fantasy points
- Suggest draft strategy
- Rank players by upside or ADP (outside of initial list generation)

## ⚙️ Framework

At the core is the **"Four Oughs" Model**, plus two situational risk factors:

- **TOUGH** – Mentality & external pressure risks (e.g. contract year push)
- **ROUGH** – Physical & medical durability (e.g. soft tissue, surgeries)
- **ENOUGH** – Volume spikes and role mismatches
- **THROWS** – Passing offense, and stack box risk from poor QBs
- **OFFS** – Hit-at-contact rate from weak offensive lines
- **DUMB** – Coaching/scheme misuse that invites injury

## 📦 system.md Usage

Put the system prompt into a ChatGPT Custom GPT, or load it via an LLM framework that supports prompt injection and function-calling. All outputs are designed to be scannable, tabular, and analytically useful for in-season or draft prep.

## 🛠️ Matrix Builder Prompts

To optimize speed and ensure freshness, this repo includes **three automated prompts** that pre-generate the full **Top 150 RB Injury Risk Matrix** once per day.

### Purpose
These prompts exist to:
- Preload player data into memory for faster user response times
- Keep injury news and team context up to date
- Reduce live lookup load for the main analyzer
- gist location https://gist.githubusercontent.com/gt8073a/fa22d4721dc053f0b89425097e9bdbfd


### How It Works
- The top 150 RBs are divided into three batches (50 players each)
- Each builder prompt processes one batch

### Output Format
- The matrix is formatted as **tab-separated values (TSV)** for easy parsing
- Compatible with spreadsheet tools, dashboards, or markdown tables

### Update Frequency
- Intended to run **once daily**
- Can be triggered via:
  - Manual run
  - Cron job
  - GitHub Actions workflow

### Benefits
- Enables instant lookup and comparisons
- Keeps the analyzer reactive to breaking injury news
- Ensures data freshness during critical draft periods

> 🧠 These prompts are utilities that power the main `system.md` prompt. They are not user-facing but play a crucial backend role.


---

*Built for precision drafters. Injury-prone rosters lose leagues — this analyzer helps you avoid them.*

