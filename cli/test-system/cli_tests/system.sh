#!/bin/bash

header "System"

# testing systems
SYSTEM_NAME_ADMIN="admin_system_$RAND"
SYSTEM_NAME_ADMIN_2=$SYSTEM_NAME_ADMIN"_2"
SYSTEM_NAME_USER="user_system_$RAND"
ACTIVATION_KEY_NAME_1="activation_key_1_$RAND"
ACTIVATION_KEY_NAME_2="activation_key_2_$RAND"


test_success "system register as admin" system register --name="$SYSTEM_NAME_ADMIN" --org="$TEST_ORG" --environment="$TEST_ENV"
skip_test_success "system register as $TEST_USER" "none" -u $TEST_USER -p password system register --name="$SYSTEM_NAME_USER" --org="$TEST_ORG" --environment="$TEST_ENV"
test_success "system info" system info --name="$SYSTEM_NAME_ADMIN" --org="$TEST_ORG"
test_success "system list" system list --org="$TEST_ORG"
test_success "system packages" system packages --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN"
test_success "system facts" system facts --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN"
test_success "system update name" system update --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN" --new-name="$SYSTEM_NAME_ADMIN_2"
test_success "system update name" system update --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN_2" --new-name="$SYSTEM_NAME_ADMIN"
test_success "system update description" system update --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN" --description="This is a description of a system. It's a great description"
test_success "system update location" system update --org="$TEST_ORG" --name="$SYSTEM_NAME_ADMIN" --location="The Grid"
test_success "system unregister" system unregister --name="$SYSTEM_NAME_ADMIN" --org="$TEST_ORG"

test_success "activation key create" activation_key create --name="$ACTIVATION_KEY_NAME_1" --description="key description" --environment="$TEST_ENV" --org="$TEST_ORG"
test_success "activation key create" activation_key create --name="$ACTIVATION_KEY_NAME_2" --description="key description" --environment="$TEST_ENV" --org="$TEST_ORG"
test_success "system register with activation key" system register --name="$SYSTEM_NAME_ADMIN" --org="$TEST_ORG" --activationkey="$ACTIVATION_KEY_NAME_1,$ACTIVATION_KEY_NAME_2"
