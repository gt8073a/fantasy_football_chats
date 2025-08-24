# Fantasy Football Health & Availability Analyzer

An AI-powered system for analyzing player durability and injury risk across all major fantasy football positions (RB, WR, TE, QB). This repository contains the prompts, automation scripts, and generated data for the analyzer.

The goal is to move beyond simple "injury-prone" labels and provide a nuanced, data-driven risk profile for every relevant player, helping fantasy managers build more resilient rosters.

---

### A Note on AI-Driven Analysis: Your Analytical Partner

It is crucial to understand the nature of this tool's output. The analysis, particularly the `Overall Risk` rating, is the result of a **qualitative synthesis** performed by a large language model. It is not a deterministic, quantitative prediction.

**This is a feature, not a bug.**

Think of this tool as your personal AI research assistant. Its primary job is to deliver data-driven, nuanced perspectives that you can use to challenge your own assumptions and gain a competitive edge.

**How to Use This Data:**

*   **As Expert-Level Smack Talk:** This is your secret weapon for league chat. The Player Cards provide a concise history of a player's durability and situational risks. It's just enough detail to sound like the smartest manager in the room and make your shallow-minded league-mates second-guess their picks.
    *   *"The AI flagged that your new RB1 has a High 'ROUGH' risk due to recurring calf strains. Bold move keeping him past week 5."*

*   **As a Sanity Check:** If the AI's rating dramatically differs from the consensus, it's a signal to dig deeper. Did it spot a weak offensive line that everyone else is ignoring?

*   **As a Strategic Tool:** Use the analysis to identify players where your league-mates might be over- or under-valuing risk, creating opportunities for you in drafts and trades.

This tool is designed to be your AI partner, arming you with the data and talking points you need to not only make more informed decisions but to dominate your league's discourse.

---

## The Core Analytical Framework

At the heart of this system is a proprietary six-factor risk model. While the specific definitions are tuned for each position, the core principles remain the same:

### The Four Universal "Ough" Factors (Player-Centric Risks)

*   **TOUGH (Mentality Risk):** Risk from a player's mindset or external pressures (e.g., playing through pain, contract year urgency).
*   **ROUGH (Physical Risk):** Risk from the player's body, conditioning, age, and career workload.
*   **ENOUGH (Volume Risk):** Risk from a projected change in workload or usage patterns.
*   **DUMB (Coaching & Scheme Risk):** Risk from the team's management, coaching staff, and offensive scheme.

### Positional Modifiers (Situation-Centric Risks)

On top of the universal factors, each position has a unique set of "Situational" risk factors that are critical to their specific role. These are defined in detail within each position's dedicated prompt documentation.

*   **For Running Backs, these include:** `OFFS (Offensive Line Risk)` and `THROWS (Passing Game Risk)`.
*   **For Wide Receivers, these might include:** `QB Play Risk` and `Scheme Target Share`.
*   *(...and so on for other positions)*

---

## How It Works: The Automated Data Pipeline

This repository uses a fully automated data pipeline powered by GitHub Actions and the Google Gemini API.

1.  **Daily Trigger:** A scheduled GitHub Action wakes up every day.
2.  **Player List Generation:** The Action uses a prompt to query the Gemini API for a current list of the top players at a given position based on Average Draft Position (ADP).
3.  **Iterative Analysis:** The Action then loops through that list, sending a highly-tuned "batch mode" prompt to the Gemini API for each player to generate their specific risk profile.
4.  **Data Publishing:** The final, clean TSV data is compiled and automatically published to a public GitHub Gist, which serves as a live data source.

---

## Current Status & Data

This project is under active development. The analysis for each position will be rolled out iteratively.

### Running Backs (RB) - ✅ **Live**

The RB model is the most mature and is updated daily.
*   **Live Data (TSV):** [Link to your RB Gist](https://gist.github.com/gt8073a/fa22d4721dc053f0b89425097e9bdbfd)
*   **System Prompt:** `prompts/rbs/system.md`

### Wide Receivers (WR) - 🟡 **In Development**
*   **Live Data (TSV):** (Coming Soon)
*   **System Prompt:** `prompts/wrs/system.md` (Coming Soon)

### Tight Ends (TE) - 🟡 **In Development**
*   **Live Data (TSV):** (Coming Soon)
*   **System Prompt:** `prompts/tes/system.md` (Coming Soon)

### Quarterbacks (QB) - 🟡 **In Development**
*   **Live Data (TSV):** (Coming Soon)
*   **System Prompt:** `prompts/qbs/system.md` (Coming Soon)

---

## How to Use

While the primary output is the daily-generated data file, the core of this project is the `system.md` prompt. This prompt can be used with any tool that can access the Gemini API (such as the official `gemini-cli` or `llm` tools) to perform live, on-demand analysis.

### Example: Local Ad-Hoc Analysis

1.  Set up your local environment with the Gemini API.
2.  Use a script or command to send the system prompt and a user prompt together:

```bash
# Example command using the llm tool
(cat prompts/rbs/system.md; echo "explain Saquon Barkley") | llm -m gemini-1.5-pro-latest -
```

