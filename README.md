# Vivah Bio — Marriage Biodata Maker

A Flutter prototype for creating, previewing, saving, and exporting marriage biodatas.

## Implemented screens

1. Splash
2. Onboarding (three swipeable pages)
3. Home dashboard
4. Template selection
5. Personal details
6. Family details
7. Education & career
8. Partner preferences
9. Photo & contact
10. Biodata preview and design customization
11. PDF export and sharing
12. My Biodatas (filters, rename, duplicate, delete)

The screen-specific UI and behavior prompts live in [`screen-prompts/`](screen-prompts/).

## Run locally

1. Install Flutter for the SDK version used by this project.
2. Run `flutter pub get` to install the image picker, PDF, printing, and shared-preferences packages.
3. Run `flutter run`.
4. Run `flutter test` to execute widget tests.

## Data and privacy

- Biodata drafts and saved documents are stored locally with shared preferences; they are not synced to a server.
- Partner preferences are excluded unless explicitly enabled.
- Phone and email are hidden in the document unless the corresponding visibility switch is enabled.
- The photo picker is opened only when the user chooses to add a photo.
- PDF sharing and print/save use the platform-provided share and print dialogs.

## Prototype notes

This is an MVP. Export currently supports PDF (A4). Saved records are local to the device, and uninstalling the app or clearing its app data may remove them. Review the generated PDF before sharing it.
