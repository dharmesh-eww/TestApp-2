# Vivah Bio — Screen UI & Functionality Prompts

This directory contains **screen-specific prompts only** for the Marriage Biodata Maker app in TestApp-2. Use these Markdown files as standalone prompts for Google Stitch or as UI/UX implementation briefs. Do not generate application code from this task; the current deliverable is prompt documentation.

## Screen prompt index

1. [Splash](01-splash.md)
2. [Onboarding](02-onboarding.md)
3. [Home Dashboard](03-home-dashboard.md)
4. [Choose Biodata Template](04-template-selection.md)
5. [Personal Details](05-personal-details.md)
6. [Family Details](06-family-details.md)
7. [Education & Career](07-education-career.md)
8. [Partner Preferences](08-partner-preferences.md)
9. [Photo & Contact Details](09-photo-contact.md)
10. [Biodata Preview & Editor](10-preview-editor.md)
11. [Export & Share](11-export-share.md)
12. [My Biodatas / Saved Documents](12-saved-biodatas.md)

## Shared design direction

- **Product:** Vivah Bio, a polished marriage biodata creator for Indian users.
- **Platform:** Mobile-first, portrait smartphone UI. Design at a modern 390 × 844 logical-pixel viewport, with responsive behavior for smaller and larger phones.
- **Visual personality:** Warm, refined, trustworthy, culturally aware, contemporary—not wedding-invitation clutter.
- **Palette:** Ivory/off-white surfaces, deep plum or wine as the primary brand color, muted antique-gold accents, charcoal text, soft rose-tinted secondary surfaces, and accessible semantic colors for errors/success.
- **Typography:** Use a highly readable modern sans-serif for UI; a restrained elegant serif may be used for decorative headings or template previews. Keep field labels and body text legible.
- **Components:** Consistent 8-point spacing rhythm, rounded cards, subtle borders/shadows, clear primary/secondary buttons, accessible touch targets (about 44 px minimum), visible focus/pressed/disabled states, inline validation, and clear loading/empty/error states.
- **Navigation:** Use a consistent top app bar with back navigation where appropriate. Multi-step forms show a step indicator, section title, concise helper text, and sticky bottom actions (“Back” and “Continue”); avoid making every field its own screen.
- **Content:** Use realistic sample data only in preview/mockup examples. Do not imply sample personal data belongs to the user. Do not require sign-in for the MVP.
- **Behavior:** Every visible control must have a clear intended action. Document transitions, validation, state retention, and edge cases. Do not add unrequested payment, social, or backend flows.
- **Accessibility:** Strong contrast, scalable text, descriptive icons, labels that remain visible while typing, keyboard-aware forms, screen-reader names, and no meaning conveyed by color alone.
- **Scope guard:** Produce only the screen described by the individual prompt. Reuse the shared visual system; do not redesign neighboring screens or invent extra screens.

## How to use

Copy one screen file at a time into Google Stitch. For a connected multi-screen prototype, generate the screens in numerical order and preserve the same design tokens, components, and navigation conventions. These files describe UI and expected behavior; they do not ask for Flutter implementation or backend integration.