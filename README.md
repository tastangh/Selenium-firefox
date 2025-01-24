# Docker Environment for Robot Framework Web Tests

This project provides a customized Docker environment for running web tests using Robot Framework. This environment includes all the necessary dependencies and tools to ensure that tests run consistently and reproducibly.

## Contents

*   **Dockerfile:** Defines the configuration of the Docker image that creates the test environment.
*   **`run_example_tests.sh`:** A bash script used to run the Robot Framework tests.
*   **`example-test-dir/web/`:** A directory containing example Robot Framework test files.

## Dockerfile Explanation

The Dockerfile creates a Docker image by following these steps:

1.  **Base Image:** Uses a Python 3.7 (Alpine Linux-based) image as the base.
2.  **Dependencies:** Installs necessary system packages (dbus, ttf-freefont, xvfb, firefox-esr, bash, mesa-dri-gallium, mesa-egl) and Python packages (robotframework, robotframework-requests, robotframework-seleniumlibrary, setuptools).
3.  **Firefox Installation:** Installs the latest version of Firefox or Firefox ESR.
4.  **Geckodriver Installation:** Downloads and installs Geckodriver into the `/usr/bin/` directory (required for Selenium tests).
5.  **Cleanup:** Removes unnecessary files to keep the image size smaller.
6.  **Working Directory:** Sets the working directory to `/src/example-test-dir/web`.
7.  **Copy Test Files:** Copies test files from `example-test-dir/web/` to the working directory.
8.  **Port Exposure:** Exposes port 8082 (if needed).
9.  **Entry Command:** Runs the `run_example_tests.sh` script when the container starts.

## `run_example_tests.sh` Script Explanation

This bash script is used to execute the Robot Framework web tests:

1.  **Change Directory:** Navigates to the `/src/example-test-dir/web` directory.
2.  **Screen Resolution:** Sets the screen resolution to `1280x1024x24`.
3.  **Run Tests:** Runs the Robot Framework tests within a virtual X server using `xvfb-run`. The test results are saved in the `results/` directory with the date and time included in the file name.

## How to Use

1.  **Build the Docker Image:**

    ```bash
    docker build -t robot-web-tests .
    ```
2.  **Run the Docker Container:**

    ```bash
    docker run -p 8082:8082 robot-web-tests
    ```

    You can find the test results in the `results` directory.

## Requirements

*   Docker must be installed.
*   Knowledge of Robot Framework and Selenium Library is beneficial.

## Notes

*   This Dockerfile is designed to support the fully automated execution of web tests.
*   You can change the `geckodriver` and `firefox-esr` versions to suit your needs.
*   Adjust the location of your tests and the `run_example_tests.sh` script to match your project structure.
*   Tests are run in `headless` mode, so no graphical interface is required.

## Contributing

To contribute to this project, please follow these steps:

1.  Fork the project.
2.  Make your changes.
3.  Create a pull request.

## License

This project is licensed under the MIT License.