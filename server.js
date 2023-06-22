const express = require('express');
const app = express();

app.get('/api/data', (req, res) => {
  // バックエンドのロジックを実装する
  const data = { message: 'Hello from the backend!' };
  res.json(data);
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
