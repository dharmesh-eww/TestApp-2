# Screen 07 — Education & Career

## Goal
Allow users to describe education, employment, and career details clearly, with support for students, working professionals, and people who choose not to disclose these details.

## Detailed generation prompt
Design “Step 3 of 5 — Education & career” for Vivah Bio. Follow the same top app bar, progress indicator, scrollable form, and sticky bottom action bar as previous steps. Use two softly separated sections. **Education:** highest qualification (select), degree/course (text), college/university (text), and graduation year (optional). **Career:** employment status (student, employed, self-employed, not currently working, prefer not to say), occupation/job title, company/organization, work location, and annual income (optional). Income should be presented neutrally and should not dominate the visual hierarchy. Add concise helper text clarifying that optional details can be omitted. Keep fields hidden or disabled only when logically appropriate; for example, if “Student” is selected, allow current course and institution without requiring employer fields.

## Functionality and states
- Education and career fields are optional unless the app’s product requirements specify otherwise.
- Dropdowns use searchable selection sheets for long lists.
- Graduation year is limited to a reasonable range and cannot be a future year unless “currently studying” is selected.
- Income options may be ranges rather than free text; never assume currency without labeling it. For this India-focused app, label currency as INR (₹).
- Employment status changes contextual fields without deleting previously entered values.
- Back/Continue navigation preserves all entries. Continue moves to Partner Preferences.
- Save & Exit saves a draft locally where supported.
- Show clear validation for malformed year or income, but no shame-oriented or judgmental language.

## Visual constraints
Use a single-column mobile layout, readable labels, restrained dividers, and no large charts or career illustrations. Avoid making salary or job status appear compulsory.

## Output requested
Generate only this Education & Career screen with student, employed, and optional-disclosure states.