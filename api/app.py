from flask import Flask, jsonify
import json

app = Flask(__name__)


@app.route("/")
def health():
    return jsonify({"status": "ok"})


@app.route("/api/quotes")
def get_quotes():
    with open("quotes.json", "r", encoding="utf-8") as file:
        quotes = json.load(file)

    return jsonify(quotes)


@app.route("/api/quotes/<int:quote_id>")
def get_quote(quote_id):
    with open("quotes.json", "r", encoding="utf-8") as file:
        quotes = json.load(file)

    for quote in quotes:
        if quote["id"] == quote_id:
            return jsonify(quote)

    return jsonify({"error": "Quote not found"}), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)