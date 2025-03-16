from flask import Flask, request, jsonify
import sqlite3
import jwt
from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.config['SECRET_KEY'] = '125668b51aa5205a57145d6741f62c614dfcae17d63efa72865868196233f4e9'
DB_PATH = "db/database.db"

def get_db():
    db = sqlite3.connect(DB_PATH)
    db.row_factory = sqlite3.Row
    return db

def close_db(e=None):
    db = get_db()
    db.close()

app.teardown_appcontext(close_db)

def generate_token(user_id):
    today = datetime.utcnow().date()
    exp_date = today + timedelta(days=7)
    payload = {
        'user_id': user_id,
        'exp': datetime(exp_date.year, exp_date.month, exp_date.day)
    }
    return jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')

def verify_token(token):
    try:
        payload = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return payload['user_id']
    except:
        return None

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    db = get_db()
    cursor = db.execute('SELECT id, password_hash FROM users WHERE username = ?', (username,))
    user = cursor.fetchone()
    if user and check_password_hash(user['password_hash'], password):
        token = generate_token(user['id'])
        return jsonify({'token': token})
    return jsonify({'message': 'Invalid credentials'}), 401

@app.route('/articles', methods=['GET'])
def get_articles():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token missing'}), 401
    
    user_id = verify_token(token.split(' ')[1])
    if not user_id:
        return jsonify({'message': 'Invalid token'}), 401

    db = get_db()
    cursor = db.execute('SELECT id, title, image_url, seller, rating FROM articles')
    articles = [dict(row) for row in cursor.fetchall()]
    return jsonify(articles)

@app.route('/favorites', methods=['GET'])
def get_favorites():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token missing'}), 401
    
    user_id = verify_token(token.split(' ')[1])
    if not user_id:
        return jsonify({'message': 'Invalid token'}), 401

    db = get_db()
    cursor = db.execute("""
        SELECT DISTINCT a.id, a.title, a.image_url, a.seller, a.rating
        FROM favorites f
        JOIN articles a ON f.article_id = a.id
        WHERE f.user_id = ?
    """, (user_id,))
    
    favorites = [dict(row) for row in cursor.fetchall()]
    return jsonify(favorites)

@app.route('/add_favorite', methods=['POST'])
def add_favorite():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token missing'}), 401
    user_id = verify_token(token.split(' ')[1])
    if not user_id:
        return jsonify({'message': 'Invalid token'}), 401
    data = request.get_json()
    article_id = data.get('article_id')
    db = get_db()
    db.execute('INSERT OR IGNORE INTO favorites (user_id, article_id) VALUES (?, ?)', (user_id, article_id))
    db.commit()
    return jsonify({'message': 'Favorite added'})

@app.route('/remove_favorite', methods=['POST'])
def remove_favorite():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token missing'}), 401
    user_id = verify_token(token.split(' ')[1])
    if not user_id:
        return jsonify({'message': 'Invalid token'}), 401
    data = request.get_json()
    article_id = data.get('article_id')
    db = get_db()
    db.execute('DELETE FROM favorites WHERE user_id = ? AND article_id = ?', (user_id, article_id))
    db.commit()
    return jsonify({'message': 'Favorite removed'})

if __name__ == '__main__':
    app.run(host="0.0.0.0")
