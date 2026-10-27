# Screen 06 — Family Details

## Goal
Collect family information commonly included in Indian marriage biodata while keeping sensitive or culturally variable fields optional.

## Detailed generation prompt
Create the Family Details step for the Vivah Bio biodata builder. Match the same app bar, form card styling, progress indicator, and sticky bottom navigation as Personal Details. Show “Step 2 of 5” and title “Family details”, with helper copy explaining that users should fill only what they are comfortable sharing. Fields: Father’s name, Father’s occupation, Mother’s name, Mother’s occupation, Number of brothers, Number of sisters, Sibling details (optional multiline), Family type (nuclear/joint/other, optional), Family values (optional selection), and Family location (optional). Do not make religion, caste, or any family detail mandatory unless the product explicitly requires it. Use clear labels, select controls for counts and categories, and concise examples.

## Functionality
- All family fields are optional in the MVP.
- Count fields accept non-negative whole numbers and provide a sensible “Prefer not to say” or blank option.
- Conditional sibling details can appear when counts are entered, but must not erase free-text information unexpectedly.
- “Back” returns to Personal Details with values retained.
- “Continue” moves to Education & Career and allows progression even if all fields are blank.
- “Save & Exit” saves the draft and returns home.
- Optional privacy note: “Include only details you want to share.”
- Validation errors should be reserved for malformed input, not for omitted optional fields.

## Visual constraints
Keep the form calm and scannable with section grouping and enough space between fields. Avoid stereotyped family illustrations, judgmental labels, or assumptions about family structure. The UI must work with long names and different family arrangements.

## Output requested
Generate only the Family Details screen with its optional-field behavior and navigation states.