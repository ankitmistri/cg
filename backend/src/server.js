const express = require('express');
const cors = require('cors');
const { authMiddleware, allowRoles } = require('./middleware/auth');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/health', (_req, res) => res.json({ ok: true }));

app.post('/api/v1/auth/login', (req, res) => {
  const { email } = req.body;
  return res.json({ accessToken: `mock-token-${email}`, role: 'AGENT' });
});

app.get('/api/v1/entries', authMiddleware, (req, res) => {
  res.json({ message: 'entries list scoped by role', user: req.user });
});

app.post('/api/v1/entries', authMiddleware, allowRoles('AGENT', 'TEAM_LEADER'), (req, res) => {
  res.status(201).json({ message: 'entry created', payload: req.body, createdBy: req.user.id });
});

app.get('/api/v1/dashboard/summary', authMiddleware, allowRoles('TEAM_LEADER', 'MANAGER'), (_req, res) => {
  res.json({ totalEntries: 0, categorySplit: [], productSplit: [] });
});

app.post('/api/v1/users', authMiddleware, allowRoles('MANAGER'), (req, res) => {
  res.status(201).json({ message: 'user created', user: req.body });
});

const port = process.env.PORT || 4000;
app.listen(port, () => console.log(`API running on :${port}`));
