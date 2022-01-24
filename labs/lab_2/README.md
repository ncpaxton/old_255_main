# Lab 2

The goal of Lab 2 is to extend your `FastAPI` application from Lab 1. You will add a `/predict` endpoint with appropriate handling for common error scenerios. You will also add GitHub actions which can test your application on pull requests. You do not need to manage your submission via pull requests. We will need this as a base for Lab 3.

## Helpful Information

### Project Setup

Copy your code from lab 1 into a new lab folder `lab_2`. In this folder there is a training script included.

## Requirements

Build a `FastAPI` with the following:

1. `/predict` endpoint
   1. Serves an `sklearn` model. The training code is provided in this repo.
   2. Use a pydantic model for the input schema and output schema
   3. Ensure that your `/predict` endpoint leverages the pydantic models
   4. If data is passed which does not meet the input schema for the model throw an error
   5. Data is pre-processed by a transformation pipeline prior to doing the model prediction
   6. Handle bad input, extra inputs, non-matching types
   7. Add appropriate tests for scenerioes above
   8. No warnings from sklearn/scipy around versions
   9. Since you are sending data to `/predict` it will not be a `GET` and instead will be `POST`. You will need to write a `curl` or `requests` command to hit it effectively and send data. It might benefit you to write your tests first prior to actually hitting your `/predict` endpoint.
2. Keep all endpoints from `lab_1`
3. `.github/workflows/tests.yml`
   1. Performn actions on pull_request
   2. Use ubuntu-latest and python3.10
   3. Steps
         1. Checkout code
         2. Setup python
         3. Upgrade pip
         4. Install poetry
         5. Install environment
         6. Run pytest
4. `Dockerfile` for packaging and running the application
   1. Add a `HEALTHCHECK` for the API
5. `README.md` for how to build, run, and test code in app root directory (minimal, a few lines is plenty)
6. Do **not** create a `/training` endpoint since the API should not be responsible for retraining your model

Remember that we're using a REST API framework. So we expect the framework to handle some of our concerns. As you review the Objectives and Requirements keep this in mind. Try to keep everything as simple as possible while achieving the goals.

## Additional Requirements

1. All requirements of Lab 1
2. `run.sh`
   1. Trains model
   2. Moves model artifacts to api source directory
   3. Builds Docker application
   4. Run Docker application in detached mode
   5. Several curl commands to validate API responds appropraitely
3. include the following for your `pyproject.toml`. This is to ensure training version matches the solution. Note `scipy = "^1.7"` and `scikit-learn = "^1.0"` are required even though we're only predicting in our API without any training.

```{toml}
[tool.poetry.dependencies]
python = ">=3.10.0,<3.11"
fastapi = "^0.71.0"
uvicorn = "^0.16.0"
joblib = "^1.1.0"
scipy = "^1.7"
scikit-learn = "^1.0"

[tool.poetry.dev-dependencies]
pytest = "^6.2"
requests = "^2.27.1"
```

## Expected Final Folder Structure

```{text}
.
└── .gitignore
└── lab_1
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
- Docker Practices: 1 points
- Happy Path Testing: 2 points
- Failure Testing: 2 point
- Correct HTTP Status Codes: 2 points

## Time Expectations

- `lab_1` is well understood, experience with `get` vs `post` methods, and using `pytest`
  - ~8 hours
- `lab_1` went okay, but don't understand everything completely yet. Takes a while to decide next steps even with understanding.
  - ~20 hours
- Struggled with `lab_1` and have trouble writing tests with `pytest` or new endpoints in `FastAPI`
  - ~30 hours
