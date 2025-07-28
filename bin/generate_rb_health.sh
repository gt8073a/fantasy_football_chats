#!/bin/bash

# Change directory to the project root to ensure correct file paths
cd "$(dirname "$0")/.."

# Define the prompt for the Gemini CLI
PROMPT1="Generate a tab-separated list of the top 50 RBs with the following columns: Player, Team, Age, Role, Overall Risk, Last Injury"
PROMPT2="Generate a tab-separated with no header list for RBs 51 to 100 with the following columns: Player, Team, Age, Role, Overall Risk, Last Injury"
PROMPT3="Generate a tab-separated with no header list for RBs 101 to 150 with the following columns: Player, Team, Age, Role, Overall Risk, Last Injury"

# Execute the command
(cat prompts/rb_health.md; echo "$PROMPT1"; echo "$PROMPT2"; echo "$PROMPT3") | gemini - > reports/rb_health_report.tsv

echo "RB Health Report generated at reports/rb_health_report.tsv"

