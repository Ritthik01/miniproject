
import sys
import os

# Make the app directory importable
sys.path.insert(
    0,
    os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "app"))
)

import pytest
from app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True

    with app.test_client() as client:
        yield client


def test_home_page(client):
    response = client.get("/")
    assert response.status_code == 200


def test_health_check(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json["status"] == "healthy"


def test_metrics_endpoint(client):
    response = client.get("/metrics")
    assert response.status_code == 200
    assert b"webapp_user_requests_total" in response.data
