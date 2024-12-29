# escape-pod
Convert Apple Notes to Markdown!

This is the only viable approach I could find. But it seems to work!

TODO:

- [ ] Select output folder
- [ ] Handle overwrite (flag? Separate ApplesScript to rotate output folder name?)
- [ ] Handle multiple Notes windows open
- [x] Handle launching Notes and Pages
- [ ] Handle (skip) locked Notes
- [ ] Fix `#tag` being interpreted as Markdown h1
- [ ] Safely iterate over all Notes
- [ ] Convert to Markdown with Pandoc
- [ ] Run unattended

- [ ] Handle inter-Note links: Append each Note's UUID to its DOCX. Then iterate
      over the corpus to build an index of UUID : filename, and update all
      Markdown files' links.

Write markdown to an icloud folder that will be synced to all devices;
it contains a git repo which I can then commit _
