set -l actual (_fifc_test_version "3.4" -gt "3.0")
@test "version test basic gt" $status = 0

set -l actual (_fifc_test_version "3.4" -ge "3.4")
@test "version test basic ge equal" $status = 0

set -l actual (_fifc_test_version "3.5" -ge "3.4")
@test "version test basic ge greater" $status = 0

set -l actual (_fifc_test_version "3.4" -lt "3.5")
@test "version test basic lt" $status = 0

set -l actual (_fifc_test_version "3.4" -le "3.4")
@test "version test basic le equal" $status = 0

set -l actual (_fifc_test_version "3.4" -le "3.5")
@test "version test basic le lower" $status = 0

set -l actual (_fifc_test_version "3.4" -gt "3")
@test "version test length not equal" $status = 0

set -l actual (_fifc_test_version "3.4" -gt "3")
@test "version test length not equal 1" $status = 0

set -l actual (_fifc_test_version "3" -gt "3.4")
@test "version test length not equal 2" $status = 1

set -l actual (_fifc_test_version "fish 3.5.0" -gt "3.4.2")
@test "version test extract version left" $status = 0

set -l actual (_fifc_test_version "3.5.0" -gt "fish 3.4.2")
@test "version test extract version right" $status = 0
