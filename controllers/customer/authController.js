const { json } = require("express");
const db = require("../../config/db/connect");
const auth = require("../../models/customer/auth.model");
const jwt = require("jsonwebtoken");
const { promisify } = require("util");
const { logAuthEvent } = require("../../config/logger/authLogger");
const index = require("../../models/customer/index.model");

const authController = () => {};

// Utility function để lấy client IP
const getClientIP = (req) => {
  return (
    req.headers['x-forwarded-for']?.split(',')[0] ||
    req.connection.remoteAddress ||
    req.socket.remoteAddress ||
    req.ip ||
    'UNKNOWN'
  );
};

// Utility function để lấy user ID
const getUserId = (req) => {
  return req.user?.user_id || req.user?.id || 'ANONYMOUS';
};

// [GET] auth/register
authController.register = async (req, res) => {
  try {
    res.render("./pages/auth/register");
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('REGISTER_PAGE_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.render("./pages/site/404-error");
  }
};

// [POST] auth/register
authController.submitRegister = async (req, res) => {
  try {
    const clientIP = getClientIP(req);
    const phoneNumber = req.body.user_phone;

    // Validate input
    if (!phoneNumber || phoneNumber.trim() === '') {
      logAuthEvent('REGISTER', {
        userPhone: phoneNumber,
        clientIP,
        status: 'FAILED',
        message: 'Missing phone number',
      });
      return res.json({
        status: "error",
        error: "Vui lòng nhập số điện thoại",
      });
    }

    auth.registerPost(req, function (error, dupPhoneNumber, success) {
      if (error) {
        logAuthEvent('REGISTER', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: `Database error: ${error.message}`,
        });
        return res.render("./pages/site/404-error");
      }

      if (dupPhoneNumber) {
        logAuthEvent('REGISTER', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: 'Duplicate phone number',
        });
        return res.json({
          status: "error",
          error: "Số điện thoại đã được sử dụng",
        });
      }

      if (success) {
        logAuthEvent('REGISTER', {
          userPhone: phoneNumber,
          clientIP,
          status: 'SUCCESS',
          message: 'User registered successfully',
        });
        return res.json({
          status: "success",
          success: "Register successfully",
        });
      }
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('REGISTER_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.json({
      status: "error",
      error: "Lỗi hệ thống",
    });
  }
};

// [GET] /login
authController.login = async (req, res) => {
  try {
    res.render("./pages/auth/login");
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('LOGIN_PAGE_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.render("./pages/site/404-error");
  }
};

// [POST] /login
// [POST] /login
authController.submitLogin = async (req, res) => {
  try {
    const clientIP = getClientIP(req);
    const phoneNumber = req.body.user_phone;

    // Validate input
    if (!phoneNumber || phoneNumber.trim() === '') {
      logAuthEvent('LOGIN', {
        userPhone: phoneNumber,
        clientIP,
        status: 'FAILED',
        message: 'Missing phone number',
      });
      return res.json({
        status: "error",
        error: "Vui lòng nhập số điện thoại",
      });
    }

    await auth.loginPost(
      req,
      function (err, nonePhoneNumber, NotMatchPassword, success, id) {
        if (err) {
          logAuthEvent('LOGIN', {
            userPhone: phoneNumber,
            clientIP,
            status: 'FAILED',
            message: `Database error: ${err.message}`,
          });
          return res.render("./pages/site/404-error");
        }

        if (nonePhoneNumber) {
          return res.json({
            status: "error",
            error: "Số điện thoại không tồn tại.",
          });
        }

        if (NotMatchPassword) {
          return res.json({
            status: "error2",
            error: "Mật khẩu không chính xác.",
          });
        }

        if (success) {
          const token = jwt.sign(
            { id },
            process.env.JWT_SECRET,
            { expiresIn: process.env.JWT_EXPIRES }
          );

          const cookieOptions = {
            expires: new Date(
              Date.now() + process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000
            ),
            httpOnly: true,
          };
          res.cookie("userSave", token, cookieOptions);

          logAuthEvent('LOGIN', {
            userId: id,
            userPhone: phoneNumber,
            clientIP,
            status: 'SUCCESS',
            message: 'Login successful',
          });
          return res.json({
          status: "success"
          });
        }
      }
    );
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('LOGIN_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.json({
      status: "error",
      error: "Lỗi hệ thống",
    });
  }
};

authController.logout = async (req, res) => {
  try {
    const userId = getUserId(req);
    const clientIP = getClientIP(req);

    logAuthEvent('LOGOUT', {
      userId,
      clientIP,
      status: 'SUCCESS',
      message: 'User logged out',
    });

    res.cookie("userSave", "logout", {
      expires: new Date(Date.now() + 2 * 1000),
      httpOnly: true,
    });
    res.status(200).redirect("/");
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('LOGOUT_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.status(500).json({ error: 'Logout failed' });
  }
};

authController.forgotPassword = async (req, res) => {
  try {
    let header_user = await index.header_user(req);
    let header = await index.header(req);

    const title = "Quên mật khẩu";
    res.render("./pages/auth/forgot", {
      header: header,
      user: header_user,
      title,
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('FORGOT_PASSWORD_PAGE_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.render("./pages/site/404-error");
  }
};

authController.findUser = async (req, res) => {
  try {
    const clientIP = getClientIP(req);
    const phoneNumber = req.body.user_phone;

    // Validate input
    if (!phoneNumber || phoneNumber.trim() === '') {
      return res.json({
        status: "error",
        error: "Vui lòng nhập số điện thoại",
      });
    }

    auth.findNumberPhone(req, function (err, notFound, success, user_id) {
      if (err) {
        logAuthEvent('FORGOT_PASSWORD', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: `Database error: ${err.message}`,
        });
        return res.json({
          status: "error",
          error: "Lỗi truy cập.",
        });
      } else if (notFound) {
        logAuthEvent('FORGOT_PASSWORD', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: 'Phone not found',
        });
        return res.json({
          status: "notFound",
          error: "Số điện thoại không tồn tại.",
        });
      } else if (success) {
        logAuthEvent('FORGOT_PASSWORD', {
          userId: user_id,
          userPhone: phoneNumber,
          clientIP,
          status: 'SUCCESS',
          message: 'User found for password reset',
        });
        return res.json({
          status: "success",
          user_id: user_id,
        });
      }
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('FORGOT_PASSWORD_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.json({
      status: "error",
      error: "Lỗi hệ thống",
    });
  }
};

authController.forgotPasswordPost = async (req, res) => {
  try {
    const clientIP = getClientIP(req);
    const phoneNumber = req.body.user_phone;

    // Validate input
    if (!phoneNumber || phoneNumber.trim() === '') {
      return res.json({
        status: "error",
        error: "Vui lòng nhập số điện thoại",
      });
    }

    auth.findNumberPhone(req, function (err, notFound, success, user_id) {
      if (err) {
        logAuthEvent('FORGOT_PASSWORD_SUBMIT', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: `Database error: ${err.message}`,
        });
        return res.json({
          status: "error",
          error: "Lỗi truy cập.",
        });
      } else if (notFound) {
        logAuthEvent('FORGOT_PASSWORD_SUBMIT', {
          userPhone: phoneNumber,
          clientIP,
          status: 'FAILED',
          message: 'Phone not found',
        });
        return res.json({
          status: "notFound",
          error: "Số điện thoại không tồn tại.",
        });
      } else if (success) {
        logAuthEvent('FORGOT_PASSWORD_SUBMIT', {
          userId: user_id,
          userPhone: phoneNumber,
          clientIP,
          status: 'SUCCESS',
          message: 'Password reset initiated',
        });
        return res.json({
          status: "success",
          user_id: user_id,
        });
      }
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('FORGOT_PASSWORD_SUBMIT_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.json({
      status: "error",
      error: "Lỗi hệ thống",
    });
  }
};

authController.resetPassword = async (req, res) => {
  try {
    const user_new_password = req.body.user_password;
    const user_phone = req.body.user_phone;
    const clientIP = getClientIP(req);

    // Validate input
    if (!user_phone || !user_new_password) {
      logAuthEvent('RESET_PASSWORD', {
        userPhone: user_phone,
        clientIP,
        status: 'FAILED',
        message: 'Missing required fields',
      });
      return res.status(400).json({
        status: 'error',
        message: 'Vui lòng nhập đầy đủ thông tin',
      });
    }

    await auth.resetPassword(user_phone, user_new_password, function(err, results){
      if (err) {
        logAuthEvent('RESET_PASSWORD', {
          userPhone: user_phone,
          clientIP,
          status: 'FAILED',
          message: `Error: ${err.message}`,
        });
        return res.status(500).json({
          status: 'error',
          message: 'Lỗi khi đặt lại mật khẩu',
        });
      }

      logAuthEvent('RESET_PASSWORD', {
        userPhone: user_phone,
        clientIP,
        status: 'SUCCESS',
        message: 'Password reset successfully',
      });
      res.status(200).json({
        status: 'success',
        message: 'Đặt lại mật khẩu thành công',
      });
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    logAuthEvent('RESET_PASSWORD_ERROR', {
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.status(500).json({
      status: 'error',
      message: 'Lỗi hệ thống',
    });
  }
};

// [POST] /auth/change-password
authController.changePassPost = async (req, res) => {
  try {
    const user_phone = req.user?.user_phone;
    const userId = getUserId(req);
    const clientIP = getClientIP(req);
    const user_old_password = req.body.user_old_password;
    const user_new_password = req.body.user_new_password;

    // Validate input
    if (!user_old_password || !user_new_password) {
      logAuthEvent('CHANGE_PASSWORD', {
        userId,
        userPhone: user_phone,
        clientIP,
        status: 'FAILED',
        message: 'Missing password fields',
      });
      return res.status(400).json({
        status: 'error',
        message: 'Vui lòng nhập đầy đủ thông tin',
      });
    }

    auth.checkPhone(user_phone, async (err, result) => {
      if (err) {
        logAuthEvent('CHANGE_PASSWORD', {
          userId,
          userPhone: user_phone,
          clientIP,
          status: 'FAILED',
          message: `Database error: ${err.message}`,
        });
        return res.status(500).json({
          status: 'error',
          message: 'Lỗi hệ thống',
        });
      }

      const user_password = result[0]?.user_password;

      await auth.checkOldPassword(
        user_old_password,
        user_password,
        async (notMatchPassword, matchPassword) => {
          if (notMatchPassword) {
            logAuthEvent('CHANGE_PASSWORD', {
              userId,
              userPhone: user_phone,
              clientIP,
              status: 'SUSPICIOUS',
              message: 'Incorrect old password',
            });
            return res.status(401).json({
              status: 'notMatchOldPassword',
              message: "Mật khẩu cũ không chính xác!",
            });
          } else if (matchPassword) {
            auth.resetPassword(user_phone, user_new_password, function (err, results){
              if (err) {
                logAuthEvent('CHANGE_PASSWORD', {
                  userId,
                  userPhone: user_phone,
                  clientIP,
                  status: 'FAILED',
                  message: `Error: ${err.message}`,
                });
                return res.status(500).json({
                  status: 'error',
                  message: 'Lỗi khi thay đổi mật khẩu',
                });
              }

              logAuthEvent('CHANGE_PASSWORD', {
                userId,
                userPhone: user_phone,
                clientIP,
                status: 'SUCCESS',
                message: 'Password changed successfully',
              });
              res.status(200).json({
                status: 'success',
                message: 'Thay đổi mật khẩu thành công',
              });
            });
          }
        }
      );
    });
  } catch (error) {
    const clientIP = getClientIP(req);
    const userId = getUserId(req);
    logAuthEvent('CHANGE_PASSWORD_ERROR', {
      userId,
      clientIP,
      status: 'FAILED',
      message: error.message,
    });
    res.status(500).json({
      status: 'error',
      message: 'Lỗi hệ thống',
    });
  }
};

module.exports = authController;