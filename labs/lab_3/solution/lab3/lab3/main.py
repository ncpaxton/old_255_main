import logging
import os

import numpy as np
from fastapi import FastAPI, Request, Response
from fastapi_redis_cache import FastApiRedisCache, cache, cache_one_minute
from joblib import load
from pydantic import BaseModel, Extra

logger = logging.getLogger(__name__)

app = FastAPI()
model = load("model_pipeline.pkl")

LOCAL_REDIS_URL = "redis://redis:6379/0"


@app.on_event("startup")
def startup():
    redis_cache = FastApiRedisCache()
    redis_cache.init(
        host_url=os.environ.get("REDIS_URL", LOCAL_REDIS_URL),
        prefix="myapi-cache",
        response_header="X-MyAPI-Cache",
        ignore_arg_types=[Request, Response],
    )


# Use pydantic.Extra.forbid to only except exact field set from client.
# This was not required by the lab.
# Your test should handle the equivalent whenever extra fields are sent.
class House(BaseModel, extra=Extra.forbid):
    MedInc: float
    HouseAge: float
    AveRooms: float
    AveBedrms: float
    Population: float
    AveOccup: float
    Latitude: float
    Longitude: float

    def to_np(self):
        return np.array(list(vars(self).values())).reshape(1, 8)


class ListHouses(BaseModel, extra=Extra.forbid):
    houses: list[House]

    def to_np(self):
        return np.vstack([x.to_np() for x in self.houses])


class HousePrediction(BaseModel):
    predictions: list[float]


@app.get("/predict", response_model=HousePrediction)
@cache_one_minute()
async def predict(houses: ListHouses):
    predictions = model.predict(houses.to_np())
    return {"predictions": list(predictions)}


@app.get("/health")
async def health():
    return {"status": "healthy"}


# Raises 422 if bad parameter automatically by FastAPI
@app.get("/hello")
async def hello(name: str):
    return {"message": f"Hello {name}"}


# /docs endpoint is defined by FastAPI automatically
# /openapi.json returns a json object automatically by FastAPI
