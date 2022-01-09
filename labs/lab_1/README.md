# Lab 1

The goal of Lab 1 is to familiarize students with preparing their environment for the rest of the class. During this lab we will create a simple `FastAPI` application. This API will be containerized, tested, and allow for you to develop locally quickly.

## Objective

Build a `FastAPI` with the following:

1. `/hello` endpoint which takes a query parameter `name` for displaying `hello [value]`
   1. Raises a error if query parameter is not `name` and raises an appropriate HTTP status code to the client
   2. Include a comment justifying why you choose the corresponding HTTP status code. [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
2. `/` endpoint which raises a Not Implemented error and sends the appropriate HTTP status code to the client
3. `/docs` endpoint is browsable while API is running with corresponding OpenAPI documentation
4. `/openapi.json` returns a `json` object that meets the OpenAPI specification version `3+`
5. `Dockerfile` for packaging and running the application
6. `README.md` for how to build, run, and test code in app root directory (minimal, a few lines is plenty)

## Additional Requirements

1. Python 3.10
   - Use native python types instead of `typing` 
      - use

        ```{python}
        def method(item: int | str):
        ```

      - do not use

        ```{python}
        from typing import Union
        def method(item: Union[int, str]):
        ```

2. `pytest`-based testing
   1. Test failure scenerios for the code
      - [FastAPI Testing Tutorial](https://fastapi.tiangolo.com/tutorial/testing/)
3. Use `poetry` for creating environment
   - [Installing Poetry](https://python-poetry.org/docs/)
   - [Basic Usage of Poetry](https://python-poetry.org/docs/basic-usage/)
4. `Dockerfile` uses multi-stage builds to reduce image sizes
   - [Example Using Poetry](https://gabnotes.org/lighten-your-python-image-docker-multi-stage-builds/)
5. `Dockerfile` uses best practices for reducing image sizes concern `apt` cache, `pip` cache, ordering of `COPY` commands, etc.
   - [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
6. API is hosted on port `8000`
7. Testing scripts are in the parent directory of your application
   - Recommendation to run `poetry new lab1` from the directory with the scripts
8. `student_setup.sh` is edited with any docker build, run, etc. commands required to run your application.

## Helpful Information

### Project Setup

`poetry new lab1` will make your life a lot easier

### Running commands from the poetry virtual environment

`poetry` allows you to run scripts directly from it's environment in a controlled fashion. For example I have `conda` installed on my machine and it is the default `python`. When leveraging `poetry` to run `FastAPI` applications I typically do the following for local development:

```{bash}
poetry run uvicorn main:app --reload
```

this will run the uvicorn application within the context of the virtual environment created by poetry without having to source the environment.



## Grading

Grades will be given based on the following:

1. Adhesion to requirements
2. Ability to build, run, and test application using `test_setup_and_curl.sh`
3. Ability to test the code with `poetry run pytest`

### Rubric

- Functional API: 3 points
- Docker Practices: 2 points
- Happy Path Testing: 2 points
- Failure Testing: 1 point
- Correct HTTP Status Codes: 2 points

## Time Expectations

- Background with Docker, API Development, Poetry, Git, Bash, etc.
  - 2-4 hours
- Background with Git + API Development in Python or Docker
  - 8 hours
- No prerequisite background
  - 20-30 hours
