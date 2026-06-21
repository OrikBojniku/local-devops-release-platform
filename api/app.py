from flask import Flask, jsonify, request
import os
import psycopg2

app = Flask(__name__)

# Lidhja me bazen e te dhenave
def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        database=os.getenv("DB_NAME", "devops_db"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres")
    )

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok", "service": "api"})

@app.route("/tasks", methods=["GET"])
def get_tasks():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, title, status FROM tasks")
    tasks = [{"id": r[0], "title": r[1], "status": r[2]} for r in cur.fetchall()]
    conn.close()
    return jsonify(tasks)

@app.route("/tasks", methods=["POST"])
def create_task():
    data = request.json
    conn = get_db()
    cur = conn.cursor()
    cur.execute("INSERT INTO tasks (title, status) VALUES (%s, %s) RETURNING id",
                (data["title"], "pending"))
    task_id = cur.fetchone()[0]
    conn.commit()
    conn.close()
    return jsonify({"id": task_id, "status": "pending"}), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
