# Running Back (RB) Health & Durability Model

This document provides a detailed breakdown of the analytical framework used in `system.md` to assess injury risk specifically for running backs.

Running backs are the most physically demanding and injury-prone position in fantasy football. Their risk profile is unique, requiring a specialized analysis that weighs both their physical history and their immediate offensive environment. This model is the most mature in the project and serves as the foundation for all other positional analyses.

---

## RB Analytical Framework

The analysis for running backs integrates the four universal "Ough" factors with two critical, RB-specific situational modifiers.

### Universal "Ough" Factors

The analysis begins with the four universal factors defined in the main project README:
*   **TOUGH (Mentality Risk)**
*   **ROUGH (Physical Risk)**
*   **ENOUGH (Volume Risk)**
*   **DUMB (Coaching & Scheme Risk)**

While these are universal, for RBs, the **ROUGH** and **ENOUGH** factors are often the most heavily weighted due to the direct correlation between physical punishment, career workload, and injury.

### RB-Specific Positional Modifiers

These two situational factors are critical for understanding the context and quality of a running back's touches.

#### OFFS (🚧 Offensive Line Risk)
This factor measures the risk created by the quality of the offensive line. It is more than just a performance metric; it's a direct contributor to a running back's physical wear and tear.
*   A **High** risk (poor O-line) forces an RB to absorb contact at or behind the line of scrimmage, break more tackles just to get back to the line, and face more frequent, punishing collisions.
*   A **Low** risk (strong O-line) provides clean running lanes, allowing the RB to build momentum before contact and reducing the number of high-impact, low-value tackles.

#### THROWS (✈️ Passing Game Risk)
This factor measures how the team's passing offense affects the defensive alignment a running back faces.
*   A **High** risk (weak passing game) allows defenses to "stack the box" with eight or more defenders near the line of scrimmage. This creates more traffic, fewer clean running lanes, and results in more physically taxing runs for lower yardage.
*   A **Low** risk (potent passing game) forces defenses to respect the pass, keeping safeties deep and linebackers in coverage. This results in "lighter" boxes and creates more favorable running situations.

---

## Synthesizing the `Overall Risk`

The final `Overall Risk` rating is not a simple average of the six factors. It is a synthesized assessment where certain factors, particularly `ROUGH` (Physical Risk), carry more weight than others. A player with a significant injury history and a High ROUGH risk will rarely receive a Low Overall Risk rating, regardless of how good their situation is.

The combination of these six factors provides a holistic durability profile for each player, forming the basis of the daily-generated report.
