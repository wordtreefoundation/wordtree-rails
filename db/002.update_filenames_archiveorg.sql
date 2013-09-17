UPDATE books SET archive_org_id = regexp_replace(regexp_replace(filename, '\.txt$', ''), '^\d+\.', '')
WHERE filename ~ '^\d+\.';
