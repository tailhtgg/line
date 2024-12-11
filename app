from flask import Flask, request, jsonify
import os

app = Flask(__name__)

# Tạo thư mục lưu file nếu chưa tồn tại
os.makedirs("uploads", exist_ok=True)

@app.route('/save-text', methods=['POST'])
def save_text():
    try:
        # Lấy dữ liệu từ request
        data = request.json
        text = data.get('text')

        if not text:
            return jsonify({"error": "Field 'text' is required"}), 400

        # Tạo file và lưu đoạn text
        file_path = os.path.join("uploads", "text_file.txt")
        with open(file_path, "w", encoding="utf-8") as file:
            file.write(text)

        return jsonify({"message": "Text saved successfully", "file_path": file_path}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
