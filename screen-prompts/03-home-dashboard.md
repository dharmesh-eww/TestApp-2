# Screen 03 — Home Dashboard

## Goal
Give users an obvious starting point to create a new biodata or continue editing an existing one.

## Detailed generation prompt
Design the home dashboard for “Vivah Bio — Marriage Biodata Maker”. Use a clean ivory canvas, deep-plum headings and CTA, muted-gold accents, and soft rose-tinted cards. At the top, show the wordmark or a compact app bar and a small settings icon. Welcome line: “Let’s create your biodata” with a short subtitle such as “A thoughtful first impression starts here.” Make the main action a large card or button: “Create New Biodata”, with a simple document-plus icon and a one-line explanation. Below it, add a “Continue editing” section for the most recently edited biodata, showing a tiny document thumbnail, its name, last-edited time, and a Continue action. Add a “Browse templates” horizontal preview strip with 3 template cards and a “See all” action. Include a “My Biodatas” shortcut. Use believable empty-state copy when no biodata exists, not fake saved records.

## UI hierarchy
1. App bar / brand and settings.
2. Welcome heading.
3. High-visibility Create New Biodata CTA.
4. Recent draft/continue card or a helpful empty state.
5. Template previews and My Biodatas shortcut.

## Functionality
- “Create New Biodata” opens template selection or the create flow.
- “Browse templates” / “See all” opens template selection.
- A recent draft opens the editor at the last saved step.
- “My Biodatas” opens the saved documents list.
- Settings opens app preferences.
- If there are no saved documents, show an empty state with a create CTA; never show fabricated user documents.
- Keep draft progress and changes persistent locally where supported.

## Layout constraints
The screen should scroll vertically on smaller devices. Keep the main CTA visible early in the viewport and avoid an overcrowded dashboard. No authentication wall, subscription offer, or payment prompt in the MVP.

## Output requested
Generate only the home dashboard screen and show the meaningful empty and populated states where possible.