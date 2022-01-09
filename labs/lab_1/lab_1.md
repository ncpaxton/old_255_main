# Lab 1

The goal of Lab 1 is to familiarize students with preparing their environment for the rest of the class. During this lab we will create a simple `FastAPI` application. This API will be containerized, tested, and allow for you to develop locally quickly.

## Objective

Build a `FastAPI` with the following:

1. `/hello` endpoint which takes a query parameter `name` for displaying `hello [value]`
2. `/` endpoint which raises a Not Implemented error and sends the appropriate HTTP status code to the client
3. `/docs` endpoint is browsable while API is running with corresponding OpenAPI documentation
4. `Dockerfile` for packaging and running the application
5. `README.md` for how to build, run, and test code in app root directory (minimal, a few lines is plenty)

## Additional Requirements

1. Python 3.10
   - Use native python types instead of `typing` 
      - use 

        ```
        def method(item: int | str):
        ```

      - do not use

        ```
        from typing import Union
        def method(item: Union[int, str]):
        ```
2. `pytest`-based testing
   1. https://fastapi.tiangolo.com/tutorial/testing/
   2. Test failure scenerios for the code
3. Use `poetry` for creating environment
   1. https://python-poetry.org/docs/basic-usage/
4. `Dockerfile` uses multi-stage builds to reduce image sizes
5. `Dockerfile` uses best practices for reducing image sizes concern `apt` cache, `pip` cache, ordering of `COPY` commands, etc.
6. API is hosted on port `8000`

## Grading

Grades will be given based on the following:

1. Adhesion to additional requirements
2. Ability to build, run, and test application using `test_setup_and_curl.sh`
3. Ability to test the code with `pytest`