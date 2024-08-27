#!/bin/bash
# Generate `coverage/lcov.info` file
flutter test --coverage
# Generate HTML report
/c/ProgramData/chocolatey/lib/lcov/tools/bin/genhtml coverage/lcov.info -o coverage/html
# Open the report
start coverage/html/index.html