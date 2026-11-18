
import json
import unittest
from unittest.mock import mock_open, patch

from app import app


class RespoQuotesApiTests(unittest.TestCase):

    def setUp(self):
        self.client = app.test_client()
        self.quotes = [
            {"id": 1, "quote": "Test quote", "author": "Test author"}
        ]

    def test_health_endpoint(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()["status"], "ok")

    @patch("builtins.open", new_callable=mock_open)
    def test_get_all_quotes(self, mocked_file):
        mocked_file.return_value.read.return_value = json.dumps(self.quotes)
        with patch("json.load", return_value=self.quotes):
            response = self.client.get("/api/quotes")

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), self.quotes)

    @patch("builtins.open", new_callable=mock_open)
    def test_get_quote_by_id(self, mocked_file):
        with patch("json.load", return_value=self.quotes):
            response = self.client.get("/api/quotes/1")

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), self.quotes[0])

    @patch("builtins.open", new_callable=mock_open)
    def test_missing_quote_returns_404(self, mocked_file):
        with patch("json.load", return_value=self.quotes):
            response = self.client.get("/api/quotes/999")

        self.assertEqual(response.status_code, 404)


if __name__ == "__main__":
    unittest.main()
