import numpy as np
import pickle

from sklearn.datasets import load_iris
from sklearn.svm import SVC
from joblib import dump

X, y = load_iris(return_X_y=True)

clf = SVC()
clf.set_params(kernel="linear").fit(X, y)

dump(clf, "model.joblib")
