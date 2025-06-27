

import sqlite3
import gzip
import os
import blackboxprotobuf
import json

# Path to the copied NoteStore.sqlite file
db_path = '/var/folders/p3/1374hvq11zl7vm_m952xmhrc0000gn/T/tmp.kKjhGtDYEY/NoteStore.sqlite'

def main():
    # Connect to the SQLite database
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Query to get note metadata
    cursor.execute("""
        SELECT
            c.Z_PK,
            c.ZTITLE1,
            c.ZSNIPPET,
            c.ZCREATIONDATE3,
            c.ZMODIFICATIONDATE1,
            c.ZNOTEDATA,
            n.ZDATA
        FROM
            ZICCLOUDSYNCINGOBJECT c
        LEFT JOIN
            ZICNOTEDATA n ON c.ZNOTEDATA = n.Z_PK
        WHERE
            c.ZTITLE1 IS NOT NULL
        LIMIT 1
    """)

    # Fetch all the notes
    notes = cursor.fetchall()

    # Process each note
    for note in notes:
        (pk, title, snippet, creation_date, modification_date, notedata_fk, zdata) = note

        print(f"--- Note PK: {pk}, Title: {title} ---")

        if zdata:
            try:
                # Decompress the note data
                decompressed_data = gzip.decompress(zdata)
                print(f"Raw decompressed data: {decompressed_data}")
                decoded_data, message_type = blackboxprotobuf.decode_message(decompressed_data)
                print(blackboxprotobuf.protobuf_to_json(decoded_data, message_type))
            except gzip.BadGzipFile:
                print("Error: Not a valid gzip file")
        else:
            print("No data found for this note.")

        print("\n")


    # Close the database connection
    conn.close()

if __name__ == "__main__":
    main()

