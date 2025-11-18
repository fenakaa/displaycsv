from flask import Flask, render_template
import pandas as pd

app = Flask(__name__)

@app.route('/')
def index():
    # Lê o CSV fixo que está no repositório
    df = pd.read_csv("startup_data_cleaned.csv", encoding="utf-8")

    # Converte a tabela para HTML
    table_html = df.to_html(classes='table table-striped', index=False)

    # Envia a tabela para o template
    return render_template('index.html', table=table_html)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
