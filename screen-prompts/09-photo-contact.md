# Screen 09 — Photo & Contact Details

## Goal
Let users choose a profile photo and decide which contact details, if any, appear on the exported biodata.

## Detailed generation prompt
Design “Step 5 of 5 — Photo & contact” for Vivah Bio. Use the same guided-form frame and progress indicator. At the top, show a clear portrait upload card with a circular or softly rounded photo placeholder, a camera/upload icon, and actions “Add photo” and “Remove” when a photo exists. Include helper copy recommending a clear, recent portrait without requiring one. Below, provide optional contact fields: phone number, email address, and current city/address (use a city-level field by default rather than requesting a full home address). Add explicit visibility controls beside contact fields, such as “Show phone on biodata” and “Show email on biodata”; default both to off until the user explicitly opts in. Include a small privacy note: “Only details you choose to include will appear in your exported file.” Bottom actions: “Back” and “Review biodata”.

## Functionality
- Photo picker opens the platform’s image selection flow; include crop/reposition UI as a conceptual state. Ask for permissions only when needed and explain the purpose.
- Removing a photo returns to the placeholder and updates the preview.
- Validate phone/email only when provided; do not require either.
- Contact visibility toggles are independent of whether a value is entered; prevent showing an empty contact field in the final document.
- Review opens Biodata Preview & Editor and generates a preview from all saved form values and selected template.
- Back returns to Partner Preferences with values retained.
- Save draft is available through a secondary action or app-bar menu.
- Do not expose contact information by default or suggest automatic sharing.

## Visual constraints
Use an approachable, privacy-first layout with clear upload affordance, compact contact fields, and no forced photo or address. Ensure keyboard-safe scrolling and large touch targets.

## Output requested
Generate only the Photo & Contact screen with no-photo, photo-selected, and validation states.