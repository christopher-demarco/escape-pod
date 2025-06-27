# Project Progress Summary

## Goal
The primary goal is to programmatically extract Apple Notes content, including attachments and formatting, into Markdown files, moving away from the brittle GUI scripting approach.

## Current Approach (Abandoned)
The initial approach involved GUI scripting with AppleScript to copy note content to Apple Pages, export as DOCX, and then convert to Markdown using Pandoc. This was deemed too fragile and risky due to:
*   Reliance on specific application UI states.
*   Risk of data loss due to lack of versioning in Apple Notes and potential user error during UI interaction.

## New Approach: Direct Database Access
Based on research, the most robust alternative is to directly access and parse the Apple Notes SQLite database (`NoteStore.sqlite`).

### Progress Made:
1.  **Identified Database Location:** Confirmed `NoteStore.sqlite` is located in `~/Library/Group Containers/group.com.apple.notes/`.
2.  **Safe Data Handling:** Implemented a crucial safety measure by copying the `NoteStore.sqlite` and its associated files (`-wal`, `-shm`) to a temporary directory (`/var/folders/p3/1374hvq11zl7vm_m952xmhrc0000gn/T/tmp.kKjhGtDYEY`) before any inspection or processing. All operations are performed on this copy.
3.  **Database Schema Exploration:**
    *   Listed tables in `NoteStore.sqlite`, identifying `ZICNOTEDATA` (note content) and `ZICCLOUDSYNCINGOBJECT` (note metadata, titles, attachments) as key tables.
    *   Inspected the schema of `ZICCLOUDSYNCINGOBJECT`, confirming columns like `ZTITLE1`, `ZCREATIONDATE3`, `ZMODIFICATIONDATE1`, `ZNOTEDATA`, `ZATTACHMENT1`, and `ZTYPEUTI1`.
4.  **Initial Data Extraction Script (`extract_notes.py`):**
    *   Developed a Python script to connect to the copied database.
    *   Successfully queried `ZICCLOUDSYNCINGOBJECT` and `ZICNOTEDATA` to retrieve note metadata and compressed content.
    *   Confirmed that note content (`ZDATA` in `ZICNOTEDATA`) is gzipped and contains protobuf data.
    *   Implemented `gzip.decompress` to decompress the note data.
5.  **Protobuf Parsing Attempt:**
    *   Identified `blackboxprotobuf` as a suitable Python library for parsing unknown protobuf structures.
    *   Set up a Python virtual environment (`.venv`) and installed `blackboxprotobuf` within it.
    *   Attempted to use `blackboxprotobuf.decode_message` and `blackboxprotobuf.protobuf_to_json` to parse and pretty-print the decompressed note data.

### Current Challenge:
The `blackboxprotobuf` parsing is currently failing with a `KeyError: 0`, indicating an issue with the protobuf data or its interpretation by the library. The next step is to debug this parsing issue, potentially by inspecting the raw decompressed data more closely or by providing `blackboxprotobuf` with more context if possible.
