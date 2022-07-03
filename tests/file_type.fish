set actual (_fifc_file_type "tests/_resources/dir with spaces/file 71.txt")
@test "file type test txt" "$actual" = txt

set actual (_fifc_file_type "tests/_resources/dir with spaces/file.json")
@test "file type test json" "$actual" = json -o "$actual" = txt

set actual (_fifc_file_type "tests/_resources/dir with spaces/fish.png")
@test "file type test image" "$actual" = image

set actual (_fifc_file_type "tests/_resources/dir with spaces/file.bin")
@test "file type test binary" "$actual" = binary

set actual (_fifc_file_type "tests/_resources/dir with spaces/file.7z")
@test "file type test archive" "$actual" = archive

set actual (_fifc_file_type "tests/_resources/dir with spaces/file.pdf")
@test "file type test pdf" "$actual" = pdf
