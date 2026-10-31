from flask import Flask, render_template
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from flask import Response

app = Flask(__name__)

USER_REQUEST_COUNT = Counter(
    "webapp_user_requests_total",
    "Total number of user requests"
)

HEALTH_CHECK_COUNT = Counter(
    "webapp_health_checks_total",
    "Total number of health checks"
)

@app.after_request
def count_requests(response):

    from flask import request

    if request.path == "/":
        USER_REQUEST_COUNT.inc()

    elif request.path == "/health":
        HEALTH_CHECK_COUNT.inc()

    return response

def request_endpoint_not_metrics():
    from flask import request
    return request.path != "/metrics"

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/health")
def health():
    return {"status": "healthy"}

@app.route("/metrics")
def metrics():
    return Response(
        generate_latest(),
        mimetype=CONTENT_TYPE_LATEST
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
