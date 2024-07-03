#!/bin/bash

function echo_failure() {
    echo -e "\e[31m" "$@" "\e[37m"
}

function echo_success() {
    echo -e "\e[32m" "$@" "\e[37m"
}

validate="./validate-bucket-name.sh"
invalid_names=(
    # Incorrect prefix
    xn--test sthree-test
    # Incorrect suffix
    test-s3alias test--ol-s3
    # Formatted as IP address
    "127.0.0.1" "8.8.8.8" "999.999.999.999"
    # Contains illegal characters
    "my bucket" ":D" "xXmy-bucketXx"
    # Contains legal characters, but begins with a non-alphanumeric
    .bucket -bucket
    # Contains legal characters, but ends with a non-alphanumeric
    bucket. bucket-
    # Contains two adjacent periods
    my..bucket
    # Less than three characters
    m mm
    # More than 63 characters
    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
)

for bucket_name in "${invalid_names[@]}"; do
    echo "TEST: Should fail with name ${bucket_name}"
    $validate "${bucket_name}" &> /dev/null && echo_failure "Failed" || echo_success "Passed!"
done

valid_names=(
    # Minimum characters
    mmm
    # Maximum characters
    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    # Contains all legal characters
    abcdefghijklmnopqrstuvwxyz012345678.-9
)


for bucket_name in "${valid_names[@]}"; do
    echo "TEST: Should pass with name ${bucket_name}"
    $validate "${bucket_name}" &> /dev/null && echo_success "Passed!" || echo_failure "Failed"
done