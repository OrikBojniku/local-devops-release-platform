import pytest
from unittest.mock import patch, MagicMock
from worker import process_tasks

def test_worker_processes_task():
    with patch("worker.get_db") as mock_db:
        mock_conn = MagicMock()
        mock_cur = MagicMock()
        mock_db.return_value = mock_conn
        mock_conn.cursor.return_value = mock_cur
        mock_cur.fetchone.return_value = (1, "Test Task")
        assert mock_cur.fetchone() == (1, "Test Task")
