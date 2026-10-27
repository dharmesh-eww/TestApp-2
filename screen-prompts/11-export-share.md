# Screen 11 — Export & Share

## Goal
Help users create a clean, printable file and share it intentionally, with understandable settings and privacy choices.

## Detailed generation prompt
Design an Export & Share screen for Vivah Bio. Keep the selected biodata visible as a small document thumbnail at the top with its title and a success-ready status. Add a clear format choice: PDF (recommended for printing and sharing) and Image (PNG/JPG if supported). Show page size “A4” and orientation/layout controls only where meaningful. Include export quality options if the image format supports them, but keep the default settings sensible. Display a privacy reminder: “Check the preview before sharing—your file may include personal details.” The primary button should be “Create PDF” when PDF is selected, otherwise “Create image”. After successful creation, show a success panel with the generated file name and actions “Share”, “Save to device” (when supported), and “Back to preview”. Do not show payment, premium locks, or account registration.

## Functionality
- User can select a supported export format; unsupported formats must not be shown as active options.
- Generate output from the current preview state, including template, formatting, photo, and contact visibility choices.
- Show a loading/progress state while generating, then success or recoverable error feedback.
- Prevent repeated taps from launching duplicate exports while processing.
- “Share” invokes the platform share sheet only after a file has been created.
- “Save to device” handles platform storage restrictions gracefully and confirms the actual outcome.
- On error, retain the user’s biodata and settings and offer “Try again”.
- The file name should be safe and recognizable, e.g. “VivahBio_Biodata.pdf”; avoid embedding phone numbers or other sensitive data in file names.
- Back to preview returns without losing settings.

## Visual constraints
Keep export settings concise and reassure users without overloading them. Make the success state visually distinct, accessible, and actionable. Never claim a file was saved or shared before the platform confirms it.

## Output requested
Generate only the Export & Share screen with default, processing, success, and error states.