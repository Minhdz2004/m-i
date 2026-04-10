const logger = require('../config/logger/logger');

const getClientIP = (req) => {
  return (
    req.headers['x-forwarded-for']?.split(',')[0] ||
    req.connection.remoteAddress ||
    req.socket.remoteAddress ||
    req.ip ||
    'UNKNOWN'
  );
};

const securityLogger = (req, res, next) => {
  const clientIP = getClientIP(req);
  const userId = req.user?.user_id || req.user?.id || 'ANONYMOUS';
  const timestamp = new Date().toISOString();

  // Store in request for later use
  req.clientIP = clientIP;
  req.userId = userId;
  req.timestamp = timestamp;

  const originalSend = res.send;
  res.send = function (data) {
    const statusCode = res.statusCode;

    res.send = originalSend;
    return res.send(data);
  };

  next();
};

module.exports = securityLogger;