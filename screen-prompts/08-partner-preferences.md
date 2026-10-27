# Screen 08 — Partner Preferences

## Goal
Offer a respectful, optional way to add partner preferences without implying that every user must provide them.

## Detailed generation prompt
Create “Step 4 of 5 — Partner preferences” in the Vivah Bio guided form. Keep the established progress bar, top app bar, scrollable layout, and sticky Back / Continue actions. Intro copy: “Share preferences only if you’d like them included.” Group optional fields in a tidy card: preferred age range (two linked minimum/maximum selectors), preferred height range (optional), education preference, occupation preference, preferred location, and a multiline “Anything else?” field. Include an explicit toggle or checkbox “Include partner preferences in my biodata” which is off by default; when off, visually de-emphasize or collapse the preference fields while retaining their values if the user toggles back on. Use neutral language, no scoring, compatibility percentages, or discriminatory recommendations.

## Functionality
- Partner preferences are optional and excluded from the exported document unless the user opts in.
- Minimum age cannot exceed maximum age; provide inline correction.
- Height ranges must use the same units as the personal-details step.
- Text fields have reasonable character limits and show remaining count only when useful.
- Toggling the include switch off should not silently delete entered preferences.
- Back returns to Education & Career; Continue advances to Photo & Contact.
- Save & Exit saves progress.
- Avoid implying preferences are objectively correct or that the app evaluates people.

## Visual constraints
Use a compact form with section headers, short helper copy, and accessible toggle states. Keep the content neutral and private-feeling. Do not add matching, search, messaging, or profile-discovery functionality.

## Output requested
Generate only the Partner Preferences screen, including the off-by-default state and an example enabled state.