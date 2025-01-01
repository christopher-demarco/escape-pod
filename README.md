# escape-pod
Convert Apple Notes to Markdown!

This is the only viable approach I could find. But it seems to work!

### 2024-12-31 update

It sorta works, but the entire concept isn't really viable.

AppleScript is too brittle--Notes and Pages need to be in juuust the right state
or it doesn't work. But the real fatal dealbreaker is that [Apple Notes does not
make version
backups](https://github.com/christopher-demarco/zettelkasten/blob/main/Apple%20Notes%20does%20not%20backup%20versions.md).

## TODO:

- [ ] Select output folder
- [ ] Handle overwrite (flag? Separate script to rotate output folder name?)
- [ ] Handle multiple Notes windows open
- [x] Handle launching Notes and Pages
- [ ] Handle (skip) locked Notes
- [ ] Fix `#tag` being interpreted as Markdown h1
      Although if ZK, this is not terribly useful--tags are an antipattern.
      Instead curate by either inter-linking or create an index of tagged notes.
- [ ] Safely iterate over all Notes
- [x] Convert to Markdown with Pandoc
- [ ] Run unattended

- [ ] Handle inter-Note links: Append each Note's UUID to its DOCX. Then iterate
      over the corpus to build an index of UUID : filename, and update all
      Markdown files' links.

Write markdown to an icloud folder that will be synced to all devices;
it contains a git repo which I can then commit _
