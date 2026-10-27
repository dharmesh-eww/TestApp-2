# Screen 12 — My Biodatas / Saved Documents

## Goal
Give users a simple, private place to find drafts and completed biodatas, continue editing, duplicate, export again, or delete a document intentionally.

## Detailed generation prompt
Design the “My Biodatas” screen for Vivah Bio. Use a top app bar with back navigation, title “My Biodatas”, and a clear “Create new” action. Below, add compact filter chips “All”, “Drafts”, and “Completed”. Display saved items as clean cards with a miniature document thumbnail, user-defined document title (fallback: “Untitled biodata”), last-edited date, and a status badge (“Draft” or “Ready”). Each card has a primary tap action to open the preview/editor and an overflow menu for “Rename”, “Duplicate”, “Export again”, and “Delete”. Use restrained styling and no fake ratings or engagement counters. For the empty state, show a simple document illustration, headline “No biodatas yet”, supporting copy “Create your first biodata and it will appear here”, and a primary “Create biodata” button.

## Functionality
- All/Drafts/Completed filters update the list and display an accurate empty state for the selected filter.
- Tapping a card opens the correct saved draft or preview.
- Rename opens a small dialog/sheet with a prefilled title, validation for blank names, and save/cancel actions.
- Duplicate creates a separate copy with a distinguishable name such as “Copy of …”; do not overwrite the original.
- Export again uses the latest saved version and opens export flow.
- Delete requires confirmation and explains that the local saved document will be removed; offer Cancel and Delete. Do not delete on a single accidental tap.
- Sort newest-edited first by default; show a friendly date format.
- If storage or loading fails, provide a retry action and do not show an empty state as though no files exist.
- Keep saved data private and do not imply cloud sync unless implemented.

## Visual constraints
Use a scrollable list, readable card actions, a balanced empty state, and sufficient separation between destructive and safe actions. Long titles should wrap or truncate gracefully.

## Output requested
Generate only the My Biodatas screen with populated, filtered, and empty states.