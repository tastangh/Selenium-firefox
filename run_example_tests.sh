#!/bin/bash
ls -l
cd /src/example-test-dir/web
GEOMETRY="1280x1024x24"
xvfb-run robot --outputdir results/$(date +%Y%m%d_%H%M%S) tests/