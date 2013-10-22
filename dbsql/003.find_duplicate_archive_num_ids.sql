SELECT archive_org_id, array_agg(regexp_replace(filename, '\..+\.txt$', '')) AS file_id
FROM books
GROUP BY archive_org_id;
