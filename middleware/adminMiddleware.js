const db = require('../config/db/connect');
const jwt = require('jsonwebtoken')
const { promisify } = require('util')

exports.isLoggedIn = async (req, res, next) => {
    console.log(`isLoggedIn: ${req.cookies.adminSave}`);
    if (req.cookies.adminSave) {
        try {
            // 1. Verify the token
            const decoded = await promisify(jwt.verify)(req.cookies.adminSave,
                process.env.JWT_SECRET
            );
            console.log(decoded);

            // 2. Check if the admin still exist
            db.query('SELECT * FROM admin WHERE admin_id = ?', [decoded.id], (err, results) => {
                if (err) {
                    console.error('DB error in isLoggedIn:', err);
                    // If request expects JSON, return JSON error
                    if (req.headers.accept && req.headers.accept.includes('application/json')) {
                        return res.status(500).json({ success: false, message: 'Server error' });
                    }
                    return res.status(500).redirect('/admin/login');
                }
                if (!results || results.length === 0) {
                    if (req.headers.accept && req.headers.accept.includes('application/json')) {
                        return res.status(401).json({ success: false, message: 'Unauthorized' });
                    }
                    return res.status(401).redirect('/admin/login');
                }
                req.admin = results[0];
                return next();
            });
        } catch (err) {
            console.log(err)
            // If request expects JSON, return JSON 401
            if (req.headers.accept && req.headers.accept.includes('application/json')) {
                return res.status(401).json({ success: false, message: 'Invalid token' });
            }
            return res.status(401).redirect('/admin/login');
        }
    } else {
        // If fetch/ajax request, return JSON 401 so client-side fetch can handle it
        if (req.headers.accept && req.headers.accept.includes('application/json')) {
            return res.status(401).json({ success: false, message: 'Unauthorized' });
        }
        return res.status(401).redirect('/admin/login')
    }
}

exports.checkAuth = (req, res, next) => {
    console.log(`checkAuth: ${req.cookies.adminSave}`)
    if (req.cookies.adminSave) {
        res.redirect('/admin/')
    }
    else {
        next();
    }
}

exports.checkUnAuth = (req, res, next) => {
    console.log(`checkUnAuth: ${req.cookies.adminSave}`)
    if (!req.cookies.adminSave) {
        res.status(401).redirect('/admin/')
    }
    else {
        next();
    }
}
