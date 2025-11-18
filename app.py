from flask import Flask, render_template
import pandas as pd
import os

app = Flask(__name__)

@app.route('/')
def index():
    csv_path = os.path.join(os.getcwd(), "startup_data_cleaned.csv")

    if not os.path.exists(csv_path):
        return f"CSV não encontrado: {csv_path}"

    df = pd.read_csv(csv_path, encoding="utf-8")
    table_html = df.to_html(classes='table table-striped', index=False)

    return render_template('index.html', table=table_html)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
