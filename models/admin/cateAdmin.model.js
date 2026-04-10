const db = require('../../config/db/connect');
const util = require('node:util')
const query = util.promisify(db.query).bind(db)
const general = require('../general.model');
const indexAdmin = require('./indexAdmin.model');
const product = require('../customer/product.model');

const cateAdmin = function () { }

cateAdmin.getCategories = async (searchKey, page, limit) => {
    let getRowSQL = "SELECT COUNT(*) as total FROM view_cate_admin"
    let getCateSQL = "SELECT * FROM view_cate_admin"
    if (searchKey) {
        getCateSQL += " WHERE view_cate_admin.category_name LIKE '%" + searchKey + "%'"
        getCateSQL += " OR view_cate_admin.category_id LIKE '%" + searchKey + "%'"
        getRowSQL += " WHERE view_cate_admin.category_name LIKE '%" + searchKey + "%'"
        getRowSQL += " OR view_cate_admin.category_id LIKE '%" + searchKey + "%'"
    }

    //truy vấn tính tổng số dòng trong một bảng
    let rowData = await query(getRowSQL)
    let totalRow = rowData[0].total

    // tính số trang thực tế sẽ có
    let totalPage = totalRow > 0 ? Math.ceil(totalRow / limit) : 1
    // Kiểm tra đảm bảo rằng page là số nguyên hợp lệ từ 1 đến totalPage
    page = page > 0 ? Math.floor(page) : 1
    page = page <= totalPage ? Math.floor(page) : totalPage

    let start = (page - 1) * limit

    getCateSQL += " ORDER BY view_cate_admin.category_id LIMIT " + start + "," + limit;

    return new Promise((resolve, reject) => {
        db.query(getCateSQL, (err, cate) => {
            if (err) return reject(err);
            let categories = {
                categories: cate,
                searchKey: searchKey,
                totalRow: totalRow,
                totalPage: totalPage,
                page: parseInt(page),
                limit: limit,
            }
            resolve(categories)
        })
    })
}


cateAdmin.getProducts = async (searchKey, page, limit) => {
    let getRowSQL = "SELECT COUNT(*) as total FROM view_products_admin"
    let getProductSQL = "SELECT * FROM view_products_admin"
    if (searchKey) {
        getProductSQL += " WHERE view_products_admin.product_name LIKE '%" + searchKey + "%'"
        getProductSQL += " OR view_products_admin.product_id LIKE '%" + searchKey + "%'"
        getRowSQL += " WHERE view_products_admin.product_name LIKE '%" + searchKey + "%'"
        getRowSQL += " OR view_products_admin.product_id LIKE '%" + searchKey + "%'"
    }

    //truy vấn tính tổng số dòng trong một bảng
    let rowData = await query(getRowSQL)
    let totalRow = rowData[0].total

    // tính số trang thực tế sẽ có
    let totalPage = totalRow > 0 ? Math.ceil(totalRow / limit) : 1
    // Kiểm tra đảm bảo rằng page là số nguyên hợp lệ từ 1 đến totalPage
    page = page > 0 ? Math.floor(page) : 1
    page = page <= totalPage ? Math.floor(page) : totalPage

    let start = (page - 1) * limit

    getProductSQL += " ORDER BY view_products_admin.revenue DESC LIMIT " + start + "," + limit;

    return new Promise((resolve, reject) => {
        db.query(getProductSQL, (err, product) => {
            if (err) return reject(err);
            let products = {
                products: product,
                searchKey: searchKey,
                totalRow: totalRow,
                totalPage: totalPage,
                page: parseInt(page),
                limit: limit,
            }
            resolve(products)
        })
    })
}

// Get category by ID
cateAdmin.getCategoryById = async (categoryId) => {
    let sql = "SELECT * FROM categories WHERE category_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [categoryId], (err, result) => {
            if (err) return reject(err);
            resolve(result[0])
        })
    })
}

// Hide category (soft delete - set display flag to 0)
cateAdmin.deleteCategory = async (categoryId) => {
    console.log('deleteCategory model called with id:', categoryId)
    return new Promise((resolve, reject) => {
        // Hide all product variants in this category
        let hideProductVariantsQuery = "UPDATE product_variants SET product_variant_is_display = 0 WHERE product_id IN (SELECT product_id FROM products WHERE category_id = ?)"
        db.query(hideProductVariantsQuery, [categoryId], (err) => {
            if (err) {
                console.error('Error hiding product variants:', err)
                return reject(err)
            }
            
            // Hide all products in this category
            let hideProductsQuery = "UPDATE products SET product_is_display = 0 WHERE category_id = ?"
            db.query(hideProductsQuery, [categoryId], (err) => {
                if (err) {
                    console.error('Error hiding products:', err)
                    return reject(err)
                }
                
                // Hide the category itself
                let hideCategoryQuery = "UPDATE categories SET category_is_display = 0 WHERE category_id = ?"
                db.query(hideCategoryQuery, [categoryId], (err, result) => {
                    if (err) {
                        console.error('Error hiding category:', err)
                        return reject(err)
                    }
                    console.log('Category hide result:', result)
                    resolve(result.affectedRows > 0)
                })
            })
        })
    })
}

// Hide/Show category
cateAdmin.hideCategory = async (categoryId) => {
    let sql = "UPDATE categories SET category_is_display = !category_is_display WHERE category_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [categoryId], (err, result) => {
            if (err) return reject(err);
            resolve(result.affectedRows > 0)
        })
    })
}

// Get product by ID
cateAdmin.getProductById = async (productId) => {
    let sql = "SELECT * FROM products WHERE product_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [productId], (err, result) => {
            if (err) reject(err);
            resolve(result[0])
        })
    })
}

// Hide product (soft delete - set display flag to 0)
cateAdmin.deleteProduct = async (productId) => {
    return new Promise((resolve, reject) => {
        // Hide all product variants
        db.query('UPDATE product_variants SET product_variant_is_display = 0 WHERE product_id = ?', [productId], (err) => {
            if (err) return reject(err)

            // Hide the product itself
            db.query('UPDATE products SET product_is_display = 0 WHERE product_id = ?', [productId], (err, result) => {
                if (err) return reject(err)
                resolve(result.affectedRows > 0)
            })
        })
    })
}

// Hide/Show product
cateAdmin.hideProduct = async (productId) => {
    let sql = "UPDATE products SET product_is_display = !product_is_display WHERE product_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [productId], (err, result) => {
            if (err) reject(err);
            resolve(result.affectedRows > 0)
        })
    })
}

// Add category
cateAdmin.addCategory = async (categoryName, categoryDesc, categoryImg) => {
    let sql = "INSERT INTO categories (category_name, category_img) VALUES (?, ?)"
    return new Promise((resolve, reject) => {
        db.query(sql, [categoryName, categoryImg], (err, result) => {
            if (err) {
                console.error('SQL error in addCategory:', err && err.sqlMessage ? err.sqlMessage : err)
                console.error(err && err.stack ? err.stack : err)
                return reject(err)
            }
            resolve(result.affectedRows > 0)
        })
    })
}

// Update category
cateAdmin.updateCategory = async (categoryId, categoryName, categoryImg) => {
    let sql = "UPDATE categories SET category_name = ?, category_img = ? WHERE category_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [categoryName, categoryImg, categoryId], (err, result) => {
            if (err) {
                console.error('SQL error in updateCategory:', err && err.sqlMessage ? err.sqlMessage : err)
                console.error(err && err.stack ? err.stack : err)
                return reject(err)
            }
            resolve(result.affectedRows > 0)
        })
    })
}

// Dòng 220-223: Thêm sản phẩm
cateAdmin.addProduct = async (productName, productPrice, productDesc, categoryId, productAvtImg) => {
    let sql = "INSERT INTO products (product_name, category_id, product_avt_img, product_price, product_description) VALUES (?, ?, ?, ?, ?)"
    return new Promise((resolve, reject) => {
        db.query(sql, [productName, categoryId, productAvtImg, productPrice, productDesc], (err, result) => {
            if (err) {
                console.error('SQL error in addProduct:', err && err.sqlMessage ? err.sqlMessage : err)
                return reject(err)
            }
            resolve(result.affectedRows > 0)
        })
    })
}

// Dòng 235-247: Sửa sản phẩm
cateAdmin.updateProduct = async (productId, productName, productPrice, productDesc, categoryId, productAvtImg) => {
    let sql = "UPDATE products SET product_name = ?, product_avt_img = ?, product_price = ?, product_description = ?, category_id = ? WHERE product_id = ?"
    return new Promise((resolve, reject) => {
        db.query(sql, [productName, productAvtImg, productPrice, productDesc, categoryId, productId], (err, result) => {
            if (err) {
                console.error('SQL error in updateProduct:', err && err.sqlMessage ? err.sqlMessage : err)
                return reject(err)
            }
            resolve(result.affectedRows > 0)
        })
    })
}
module.exports = cateAdmin