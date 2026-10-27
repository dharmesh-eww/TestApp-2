# Screen 04 — Choose Biodata Template

## Goal
Let users browse visual styles and select a template before entering details, without making the choice feel overwhelming.

## Detailed generation prompt
Create a mobile template gallery for “Vivah Bio”. Present a top bar with back arrow, title “Choose a template”, and short helper text “Pick a style—you can change it later.” Use a two-column responsive grid of premium-looking biodata preview cards. Each card should resemble a miniature paper document with a visible title area, profile-photo placeholder, section labels, subtle ornamental border, and varied but restrained styles (classic ivory, modern minimal, floral accent, traditional gold, contemporary plum). Distinguish templates by layout and typography, not only color. Add a small “Free” or “Premium” label only when relevant; do not gate selection behind payment in this MVP. Provide a selected state with a plum outline/checkmark and a sticky bottom button “Use This Template” that is disabled until a template is selected. Include a simple category filter row such as “All”, “Classic”, “Modern”, “Traditional”.

## Components and behavior
- Search/filter controls only if they can be represented cleanly; do not crowd the grid.
- Each template card has a name and accessible selection state.
- Tapping a card selects it; tapping again keeps it selected.
- Category filters update the visible cards and preserve selection when possible.
- “Use This Template” advances to Personal Details and carries the selected template into the preview flow.
- Template can be changed later from the preview/editor.
- Empty filter results show a friendly message and a reset-filter action.

## Design constraints
Keep template thumbnails legible at small sizes and the grid balanced. Cards should feel like actual document previews, not generic colored rectangles. Provide enough spacing for comfortable tapping and make labels readable.

## Output requested
Generate only the template selection screen with selected/unselected and filtered states.