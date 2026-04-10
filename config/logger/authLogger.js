const logger = require('./logger');

const logAuthEvent = (eventType, details) => {
  const {
    userId,
    userPhone,
    clientIP,
    status,
    message,
    timestamp = new Date().toISOString(),
  } = details;

  const securityLog = `[${eventType}] User ID: ${userId || 'ANONYMOUS'} | Phone: ${userPhone || 'N/A'} | IP: ${clientIP || 'UNKNOWN'} | Status: ${status} | Message: ${message}`;

  const logLevel =
    status === 'FAILED' || status === 'SUSPICIOUS' ? 'error' : 'info';

  logger.log({
    level: logLevel,
    message: securityLog,
  });
};

const logAPIEvent = (eventType, details) => {
  const {
    userId,
    clientIP,
    method,
    route,
    statusCode,
    message,
  } = details;

  const apiLog = `[${eventType}] User ID: ${userId || 'ANONYMOUS'} | IP: ${clientIP || 'UNKNOWN'} | ${method} ${route} | Status: ${statusCode} | ${message}`;

  const logLevel = statusCode >= 400 ? 'warn' : 'http';

  logger.log({
    level: logLevel,
    message: apiLog,
  });
};

module.exports = { logAuthEvent, logAPIEvent };
