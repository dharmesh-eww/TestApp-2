# Screen 10 — Biodata Preview & Editor

## Goal
Show the user a realistic final document preview and let them refine content and style before export.

## Detailed generation prompt
Create the Biodata Preview & Editor screen for Vivah Bio. Use a compact app bar with back navigation and a title “Preview biodata”. The main canvas should display a high-fidelity, paper-like biodata page with a subtle shadow against a neutral background. The document must look like a real A4/printable page scaled to fit the phone: template header, optional portrait, name, clearly grouped sections (Personal, Family, Education & Career, and optionally Partner Preferences and Contact), elegant dividers, and consistent typography. Populate with clearly fictional sample details only for the mockup. Keep text readable and avoid excessive floral graphics. Above or below the canvas, include a small toolbar with “Edit details”, “Change template”, and “Customize design”. Provide a prominent bottom CTA “Export biodata” and a secondary “Save draft” action.

## Functionality
- Preview reflects all current form data, selected template, photo, and visibility toggles in real time.
- “Edit details” returns to the relevant form step; after saving, return to the same preview position.
- “Change template” opens template selection while preserving all entered data.
- “Customize design” exposes supported design controls such as accent color, font pairing, border/decorative style, and photo placement. Keep controls simple and bounded to the chosen template.
- If no optional section has content, omit it instead of showing empty headings.
- Contact details appear only if the user opted to show them.
- Allow zooming or opening a fit-to-page/full-page preview, but do not make the document impossible to navigate on small phones.
- “Export biodata” opens Export & Share.
- Saving a draft provides clear confirmation and does not create duplicate documents on every tap.

## Visual constraints
The preview document is the visual hero. Keep app chrome secondary, avoid excessive toolbars, and preserve realistic print proportions. The document should be export-oriented, not a social profile page.

## Output requested
Generate only the preview/editor screen with a realistic populated document and a clear blank/partially completed fallback state.