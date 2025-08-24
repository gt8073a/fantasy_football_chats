# To-Do List & Roadmap for the RB Health Analyzer

This document tracks the planned feature enhancements and research tasks for the Running Back analysis model.

---

### 1. Decouple Player List Generation from Analysis

-   **Priority:** High
-   **Effort:** Low

**Description:**
The current GitHub Action generates the player list and analyzes players within the same step, repeated in chunks. This is brittle. The process should be separated into two distinct phases: first, generate a definitive list of all players to be analyzed, and second, iterate through that static list to perform the health analysis on each player.

**Rationale:**
-   **Reliability:** Isolates the riskiest step (web search for a comprehensive ADP list) into a single action. If this one step succeeds, the rest of the pipeline becomes much more reliable.
-   **Consistency:** Ensures that all analysis is performed on a single, coherent player list, preventing discrepancies that could arise from multiple, separate AI queries.
-   **Debuggability:** If the action fails, we will know immediately if the issue was in list generation or during the analysis of a specific player.

**Implementation Notes:**
-   Modify the main GitHub Action workflow (`generate_report.yml`).
-   Create a new initial step that runs a dedicated prompt (e.g., `prompts/rbs/get_player_list.md`) to generate the full list of top 100-150 RBs.
-   Save this output to a temporary file within the runner (e.g., `player_list.txt`).
-   Subsequent steps will then read from `player_list.txt` in a loop, calling the analysis prompt for each player name.

---

### 2. Implement Player-Level Caching and Change Detection

-   **Priority:** Low
-   **Effort:** High

**Description:**
Instead of re-analyzing all 100+ RBs from scratch every day, develop a system to cache the detailed "Player Card" for each RB. The daily GitHub Action would then perform a "change detection" check. A full re-analysis would only be triggered for a player if significant new information (e.g., a new injury, a trade, a major depth chart change) is detected.

**Rationale & The "Is this really optimized?" Question:**
This is a trade-off. It would dramatically reduce the number of *full analysis* API calls per day (from ~150 down to maybe 5-10 on an average day), saving costs and speeding up the main run. However, it introduces significant complexity and requires a "light" API call for *every single player* just to check for new information. The optimization is in the *depth* of the call, not necessarily the *number* of calls.

**Implementation Notes:**
-   **Storage:** The cache could be a directory of individual markdown files in a separate Gist or a dedicated branch of the repo (e.g., `/reports/rbs/players/breece-hall.md`).
-   **Change Detection:** The daily Action would loop through the master player list. For each player, it would run a new, very simple prompt like: *"For [Player Name], has there been any significant injury news or team situation change in the last 24 hours? Answer ONLY with 'YES' or 'NO'."*
-   **Trigger:** If the response is 'YES', the Action would then trigger the full, deep-dive analysis for that player and overwrite their cached file.

---

### 3. Re-evaluate and Refine the OFFS (Offensive Line) Risk Factor

-   **Priority:** Low (for now)
-   **Effort:** Medium

**Description:**
The current `OFFS` model operates on the conventional wisdom that a "bad" offensive line increases a running back's injury risk. This assumption should be challenged and refined with a more nuanced, data-driven approach.

**Rationale:**
A more sophisticated model for `OFFS` risk would significantly increase the credibility and accuracy of the entire analysis. It moves from "common knowledge" to a truly expert-level insight.

**Research & Implementation Notes:**
-   The core task is to research the statistical correlation between specific O-line metrics and RB games missed due to injury.
-   **Key Questions to Investigate:**
    1.  Do RBs with lower PFF run-blocking grades on their O-line actually miss more games?
    2.  Does the *type* of contact matter more than the frequency? Is getting hit in the backfield (a "stuff") more physically taxing than getting hit at the second level?
    3.  Does the offensive scheme (e.g., wide zone vs. power gap) have a greater impact on RB health than the raw talent of the linemen?
-   **Data Sources:** Pro Football Focus (PFF), Football Outsiders, and other advanced football analytics sites would be the primary sources.
-   **Final Output:** The research would conclude with a revised, more detailed definition for the `OFFS` factor in the `system.md` prompt.

---

---

### 4. Transition Data Sourcing from ADP to In-Season ECR

-   **Priority:** Critical
-   **Effort:** Low

**Description:**
As the NFL season begins, Average Draft Position (ADP) becomes a stale, historical metric. The data acquisition prompts for player list generation must be updated to be "season-aware." They need to use ADP during the pre-season and then automatically switch to using current Expert Consensus Rankings (ECR) once the regular season starts.

**Rationale:**
-   **Data Relevancy:** Ensures that the daily-generated reports are always based on the most current and relevant player valuations, maintaining the tool's credibility and utility throughout the entire season.
-   **User Trust:** Using up-to-date ECR in-season demonstrates that the tool is actively maintained and not just a "draft season" utility.

**Implementation Notes:**
-   Modify the data acquisition prompts in the GitHub Action script (e.g., `scripts/find_players.sh`) and in the interactive prompt's `## Generate Player Rankings` task.
-   The new prompt logic should contain a conditional instruction: "IF the current date is pre-season, use ADP. IF the current date is in-season (Week 1 or later), use ECR for the rest of season."

