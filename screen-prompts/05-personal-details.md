# Screen 05 — Personal Details

## Goal
Collect essential personal information in a reassuring, structured first form step.

## Detailed generation prompt
Design the Personal Details step of a guided marriage-biodata form. Use the shared Vivah Bio design system. The top app bar includes a back arrow and “Create biodata”. Beneath it show a progress indicator such as “Step 1 of 5” and a horizontal progress bar. Page title: “Personal details”; helper text: “Start with the basics. You can review everything before exporting.” Use a vertically scrollable form with visible labels above inputs and these fields: Full name (required), Date of birth (date picker), Age (derived from date of birth where possible, with an editable/clear rule clearly defined), Gender (optional/selectable), Height (picker with metric and feet/inches display), Marital status (select), Religion (optional), Community/caste (optional), Mother tongue (optional), and Current city (optional). Use short examples as placeholders, not as labels. Add discreet optional badges for non-required fields. Bottom sticky actions: “Save & Exit” as secondary and “Continue” as primary.

## Functionality and validation
- Full name is required; show inline validation on continue and move focus to the first invalid field.
- Date picker must prevent future dates. If age is derived, update it when DOB changes and avoid conflicting editable DOB/age values.
- Height supports a clear unit convention and accessible selection.
- Dropdowns open usable selection sheets; selected values appear in the field.
- Preserve entered values when navigating back or leaving to save a draft.
- “Continue” moves to Family Details only after required validation passes.
- “Save & Exit” saves a draft and returns to the dashboard, with clear feedback.
- Show keyboard-safe scrolling and do not hide the focused field behind the bottom actions.

## Layout and quality
Avoid a long, intimidating form. Group related optional fields under “More about you” if needed. Use a single-column layout, 44 px minimum touch targets, clear required markers, and calm validation copy.

## Output requested
Generate only this form step, including empty, focused, selected, and validation examples.