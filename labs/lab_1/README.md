# Lab 1

The goal of Lab 1 is to familiarize students with preparing their environment for the rest of the class. During this lab we will create a simple `FastAPI` application. This API will be containerized, tested, and allow for you to develop locally quickly.

## Working Repository

You should have a repo in [GitHub](https://github.com/orgs/UCB-W255/) with a name following the following standard `[TERM][YEAR]-[GITHUB_USERNAME]`. For example: <https://github.com/UCB-W255/spring22-jameswinegar>. All work for all labs and project should be done in this repository with the following folder structure:

```{text}
.
└── lab_1
└── lab_2
└── lab_3
└── lab_4
└── lab_5
└── project
```

You do not need to manage pull requests, etc. Instructors and TAs will pull down code when they go to grade. Submission timelines are on the honor system, but we will be grading quickly to provide meaningful feedback.

## Helpful Information

### .gitignore

Add a `.gitignore` file to the root of your repo with the following:

<https://github.com/github/gitignore/blob/main/Python.gitignore>

### Project Setup

`poetry new lab1` will make your life a lot easier

This will change your folder structure to the following:

```{text}
.
└── lab_1
   └── lab1
      ├── README.rst
      ├── lab1
      │   ├── __init__.py
      │   └── main.py
      ├── poetry.lock
      ├── pyproject.toml
      └── tests
         ├── __init__.py
         └── test_lab1.py
└── lab_2
└── lab_3
└── lab_4
└── lab_5
└── project
```

### Running commands from the poetry virtual environment

`poetry` allows you to run scripts directly from it's environment in a controlled fashion. For example I have `conda` installed on my machine and it is the default `python`. When leveraging `poetry` to run `FastAPI` applications I typically do the following for local development:

```{bash}
poetry run uvicorn main:app --reload
```

this will run the uvicorn application within the context of the virtual environment created by poetry without having to source the environment.

## Objective

Build a `FastAPI` with the following:

1. `/hello` endpoint which takes a query parameter `name` for displaying `hello [value]`
   1. Raises a error if query parameter is not `name` and raises an appropriate HTTP status code to the client
   2. Include a comment justifying why you choose the corresponding HTTP status code. [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
2. `/` endpoint which is not implemented. You should raises a HTTP exception and sends the appropriate HTTP status code to the client
3. `/docs` endpoint is browsable while API is running with corresponding OpenAPI documentation
4. `/openapi.json` returns a `json` object that meets the OpenAPI specification version `3+`
5. `Dockerfile` for packaging and running the application
6. `README.md` for how to build, run, and test code in app root directory (minimal, a few lines is plenty)

Remember that we're using a REST API framework. So we expect the framework to handle some of our concerns. As you review the Objectives and Requirements keep this in mind. Try to keep everything as simple as possible while achieving the goals.

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
   - [Installing Poetry](https://python-poetry.org/docs/master/#installing-with-the-official-installer)
   - [Basic Usage of Poetry](https://python-poetry.org/docs/basic-usage/)
4. `Dockerfile` uses multi-stage builds to reduce image sizes
   - [Example Using Poetry](https://gabnotes.org/lighten-your-python-image-docker-multi-stage-builds/)
5. `Dockerfile` uses best practices for reducing image sizes concern `apt` cache, `pip` cache, ordering of `COPY` commands, etc.
   - [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
6. API is hosted on port `8000`
7. Testing scripts are in the parent directory of your application
   - Recommendation to run `poetry new lab1` from the directory with the scripts
8. Create a `run.sh` file in the `lab1` root that will do the following:
      - Build docker container
      - Run docker container in detached mode `-d` so that script can continue
      - curl defined endpoints and return status codes (examples below):

        ```{bash}
         curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/hello?name=Winegar"
         curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/"
         curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/docs"
        ```

9. Do not use `poetry run [COMMAND]` for the final `CMD` of your docker container especially when using multi-stage builds where you are isolating your build requirements from your runtime requirements.

## Expected Final Folder Structure

```{text}
.
└── .gitignore
└── lab_1
   ├─── run.sh
   ├─── README.md
   └─── lab1
      ├─── Dockerfile
      ├── README.rst
      ├── lab1
      │   ├── __init__.py
      │   └── main.py
      ├── poetry.lock
      ├── pyproject.toml
      └── tests
         ├── __init__.py
         └── test_lab1.py
├── lab_2
├── lab_3
├── lab_4
├── lab_5
└── project
```

## Grading

Grades will be given based on the following:

1. Adhesion to requirements
2. Ability to build and run application using `run.sh`
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
