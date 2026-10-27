# Screen 01 — Splash

## Goal
Create a polished first-launch screen for **Vivah Bio — Marriage Biodata Maker** that establishes trust and communicates the app’s purpose immediately.

## Detailed generation prompt
Design a mobile splash screen for an Indian marriage biodata maker app named “Vivah Bio”. Use a warm ivory background with a subtle, barely visible ornamental line pattern inspired by Indian stationery; keep it sophisticated and uncluttered. Center a custom typographic wordmark, “Vivah Bio”, with a small refined document/flower emblem. Under it, add the tagline “Your story, beautifully presented.” Use deep plum for the brand mark and a small antique-gold detail. Near the bottom, show a discreet loading indicator and the text “Preparing your workspace…”. Respect the device safe areas and avoid any buttons, ads, or large photography.

## UI elements
- Brand emblem and wordmark centered in the visual field.
- One-line tagline with readable contrast.
- Subtle loading indicator near the lower portion.
- Background decoration must remain low contrast and not interfere with legibility.

## Functionality and states
- Show while app initialization completes, then route to onboarding on first launch or the home dashboard on subsequent launches.
- Loading indicator is visual feedback only; do not imply a percentage if progress is unknown.
- If initialization fails, the app should move to a recoverable error state with a retry action rather than remain on the splash indefinitely. This error state is behavior guidance, not a separate design deliverable.

## Layout and quality constraints
Use a portrait 390 × 844 viewport, responsive constraints, generous negative space, and a clear visual center. Keep the logo and text away from cutouts and system bars. No login form, template grid, or home navigation on this screen.

## Output requested
Generate only the splash-screen UI concept with enough visual detail to guide implementation.