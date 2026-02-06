# Rotation Comparison System

A framework for comparing rotation generation quality across multiple LLMs (Kimi, Claude Opus, Gemini 3 Pro) using different class guides (Wowhead, Icy Veins, Method.gg).

## Structure

### One Sheet Per Class
Each WoW class gets its own sheet/page:
- Death Knight
- Demon Hunter
- Druid
- Evoker
- Hunter
- Mage
- Monk
- Paladin
- Priest
- Rogue
- Shaman
- Warlock
- Warrior

### Rows: Spec + Source + Rotation Type
For each spec in a class, we compare:
| Source | Rotation Type |
|--------|---------------|
| Wowhead | ST |
| Wowhead | AOE |
| Icy Veins | ST |
| Icy Veins | AOE |
| Method.gg | ST |
| Method.gg | AOE |

### Columns: LLM Results
| Column | Content |
|--------|---------|
| Spec | Class specialization |
| Source | Guide source (Wowhead/Icy Veins/Method.gg) |
| Type | ST (Single Target) or AOE |
| Kimi (This LLM) | Score/result for this LLM |
| Claude Opus | Score/result for Claude |
| Gemini 3 Pro | Score/result for Gemini |
| Notes | Free-form notes about issues found |

## Example: Evoker Sheet

```
Spec          | Source    | Type | Kimi | Claude | Gemini | Notes
--------------|-----------|------|------|--------|--------|-------
Devastation   | Wowhead   | ST   | 5    | 4      | 4      | Perfect
Devastation   | Wowhead   | AOE  | 5    | 3      | 4      | 
Devastation   | Icy Veins | ST   | 4    | 4      | 3      | Minor issues
Devastation   | Icy Veins | AOE  | 4    | 3      | 3      |
Devastation   | Method.gg | ST   | 5    | 5      | 4      | Excellent
Devastation   | Method.gg | AOE  | 5    | 4      | 4      |
Preservation  | Wowhead   | ST   | ...  | ...    | ...    |
[etc for all specs and sources]
```

## Scoring Guide

### 5 / Pass - Perfect
- Follows all patterns from QUICK_REFERENCE.yaml
- Proper syntax throughout
- Handles edge cases (empowered spells, morphs, etc.)
- Correct hero talent detection
- Proper config setup

### 4 - Good
- Minor issues (cosmetic, naming)
- Mostly correct syntax
- May miss one edge case
- Functions correctly with small tweaks

### 3 - Acceptable
- Works but has notable issues
- May miss spell morphs
- Suboptimal but functional
- Requires some fixes

### 2 - Poor
- Significant problems
- May not function correctly
- Wrong patterns used
- Missing critical features

### 1 / Fail - Broken
- Syntax errors
- Wrong patterns that won't work
- Missing spell morphs causing rotation breaks
- Incorrect structure

## Common Failure Points to Check

1. **Equality operator**: Uses `==` instead of `=`
2. **movement_allowed**: Placed inside variables (should be root level)
3. **main list**: Called explicitly (should auto-execute)
4. **Spell morphs**: Missing `override` (causes rotation to BREAK)
5. **Empowered spells**: Missing `ignore_usable` + `casting_check`
6. **Hero talents**: Incorrect detection
7. **Precedence**: Missing parentheses for `&` `|` operators
8. **References**: Wrong `config.X` vs `var.X` usage

## Files Generated

### If openpyxl is installed:
- `rotation_comparison.xlsx` - Single Excel file with 14 sheets (Summary + 13 classes)

### If openpyxl not installed (CSV fallback):
- `rotation_comparison_csv/` directory with:
  - `_summary.csv` - Overview and scoring guide
  - `{class}_comparison.csv` - One file per class

## How to Use

1. **Generate rotations** using the same prompt template for each LLM:
   - Kimi (this LLM)
   - Claude Opus
   - Gemini 3 Pro

2. **Evaluate each rotation** against the scoring criteria

3. **Fill in the scores** in the comparison sheet:
   - Open Excel/CSV for the class
   - Score each spec/source/rotation type
   - Add notes about specific issues found

4. **Analyze results**:
   - Which LLM handles certain patterns better?
   - Which class/spec is hardest to get right?
   - Common failure patterns across LLMs?

## Re-generating the Template

```bash
# With openpyxl (Excel output)
pip install openpyxl
python generate_comparison_workbook.py

# Without openpyxl (CSV output)
python generate_comparison_workbook.py

# Custom output path
python generate_comparison_workbook.py --output my_comparison.xlsx
```

## Integration with Workflow

Use this comparison system with the prompt template:

1. Run the same prompt through all 3 LLMs
2. Each LLM generates their version of the rotation
3. Evaluate each against the quick reference patterns
4. Score in the comparison sheet
5. Identify best practices from each LLM

## Interpreting Results

### High variance on a specific spec?
→ That spec has complex mechanics that need clearer documentation

### One LLM consistently lower?
→ May need better examples of patterns for that LLM

### Common failures across all LLMs?
→ Need to improve QUICK_REFERENCE.yaml documentation

## Total Comparisons

- **13 classes** × **variable specs** × **3 sources** × **2 rotation types**
- Evoker: 3 specs × 3 sources × 2 types = 18 comparisons
- Druid: 4 specs × 3 sources × 2 types = 24 comparisons
- etc.

Total: ~200+ individual rotation comparisons across all classes

## Notes Column Usage

Use the Notes column to record:
- Specific syntax errors found
- Missing features (morphs, hero talents, etc.)
- Pattern violations
- Whether rotation actually works in-game
- Comparison to other LLM results ("Kimi got morphs right, Claude missed them")
