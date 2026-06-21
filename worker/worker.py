import os
import time
import psycopg2

# Lidhja me bazen e te dhenave
def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        database=os.getenv("DB_NAME", "devops_db"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres")
    )

def process_tasks():
    print("Worker startoi — duke pritur detyra...")
    while True:
        try:
            conn = get_db()
            cur = conn.cursor()

            # Merr detyrat me status "pending"
            cur.execute("SELECT id, title FROM tasks WHERE status = 'pending' LIMIT 1")
            task = cur.fetchone()

            if task:
                task_id, title = task
                print(f"Duke procesuar detyre: {title}")

                # Simulon pune (2 sekonda)
                time.sleep(2)

                # E sheno si e kryer
                cur.execute("UPDATE tasks SET status = 'done' WHERE id = %s", (task_id,))
                conn.commit()
                print(f"Detyra {task_id} u krye.")

            conn.close()

        except Exception as e:
            print(f"Gabim: {e}")

        time.sleep(5)

if __name__ == "__main__":
    process_tasks()
