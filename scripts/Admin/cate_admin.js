document.addEventListener('DOMContentLoaded', function() {
    console.log('cate_admin.js DOMContentLoaded fired')
    
    // Global flag to prevent multiple delete operations
    let isDeleting = false
    
    // check checkbox
    const checkboxAll = document.querySelector('.checkbox')
    const checkboxes = Array.from(document.querySelectorAll('.checkbox')).slice(1)

    if (checkboxAll) {
        checkboxAll.addEventListener('click', checkAll)
    }
    checkboxes.forEach(checkbox => checkbox.addEventListener('click', checkOne))

    function checkAll() {
        checkboxes.forEach(checkbox => checkbox.checked = checkboxAll.checked)
    }

    function checkOne(event) {
        if (checkboxAll) {
            checkboxAll.checked = checkboxes.every(checkbox => checkbox.checked)
        }
    }

    // Handle dropdown toggle for mobile/touch devices
    const dropdownToggles = document.querySelectorAll('.action__dropdown > li > span.material-symbols-rounded')
    
    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault()
            e.stopPropagation()
            
            // Close all other dropdowns
            document.querySelectorAll('.dropdown__list').forEach(list => {
                if (list !== this.nextElementSibling) {
                    list.style.display = 'none'
                }
            })
            
            // Toggle current dropdown
            const dropdownList = this.nextElementSibling
            if (dropdownList) {
                const isVisible = dropdownList.style.display === 'block'
                dropdownList.style.display = isVisible ? 'none' : 'block'
            }
        })
    })
    
    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.action__dropdown')) {
            document.querySelectorAll('.dropdown__list').forEach(list => {
                list.style.display = 'none'
            })
        }
    })
    const deleteCategoryButtons = document.querySelectorAll('.btn-delete-category')
    const deleteProductButtons = document.querySelectorAll('.btn-delete-product')
    
    // Direct binding for delete buttons
    deleteCategoryButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault()
            e.stopPropagation()
            console.log('Delete button clicked, isDeleting:', isDeleting)
            
            // Prevent multiple delete operations
            if (isDeleting) {
                console.log('Delete already in progress, ignoring click')
                return
            }
            
            const id = this.getAttribute('data-id')
            if (!id) return
            
            // Prevent double clicks
            if (this.disabled) return
            this.disabled = true
            const originalText = this.textContent
            this.textContent = 'Đang xử lý...'
            
            const userConfirm = confirm('⚠️ Bạn có chắc muốn xóa danh mục #' + id + ' và tất cả sản phẩm trong đó ?\n\nThao tác này không thể hoàn tác!')
            if (!userConfirm) {
                this.disabled = false
                this.textContent = originalText
                return
            }
            
            isDeleting = true
            performCategoryDelete(id, this, originalText, () => { isDeleting = false })
        })
    })
    
    deleteProductButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault()
            e.stopPropagation()
            const id = this.getAttribute('data-id')
            if (!id) return
            
            const userConfirm = confirm('⚠️ Bạn có chắc muốn xóa sản phẩm #' + id + ' ?\n\nThao tác này không thể hoàn tác!')
            if (!userConfirm) return
            
            fetch(`/admin/products_admin/delete/${id}`, {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(r => r.json())
            .then(result => {
                if (result.success) {
                    alert('✅ ' + result.message)
                    window.location.reload()
                } else {
                    alert('❌ Lỗi: ' + result.message)
                }
            })
            .catch(err => {
                console.error(err)
                alert('❌ Lỗi khi xóa sản phẩm')
            })
        })
    })

    // Event delegation for dropdown menus (DISABLED to prevent double triggering)
    /*
    document.addEventListener('click', function (e) {
        console.log('Delegate click event:', e.target.className, e.target.tagName)
        
        // category delete
        if (e.target && e.target.classList && e.target.classList.contains('btn-delete-category')) {
            e.preventDefault()
            e.stopPropagation()
            const id = e.target.getAttribute('data-id')
            console.log('Delegate: Category delete clicked, id:', id)
            if (!id) return
            
            const userConfirm = confirm('⚠️ Bạn có chắc muốn xóa danh mục #' + id + ' và tất cả sản phẩm trong đó ?\n\nThao tác này không thể hoàn tác!')
            if (!userConfirm) return
            
            performCategoryDelete(id)
        }

        // product delete
        if (e.target && e.target.classList && e.target.classList.contains('btn-delete-product')) {
            e.preventDefault()
            e.stopPropagation()
            const id = e.target.getAttribute('data-id')
            if (!id) return
            
            const userConfirm = confirm('⚠️ Bạn có chắc muốn xóa sản phẩm #' + id + ' ?\n\nThao tác này không thể hoàn tác!')
            if (!userConfirm) return
            
            fetch(`/admin/products_admin/delete/${id}`, {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(r => r.json())
            .then(result => {
                if (result.success) {
                    alert('✅ ' + result.message)
                    window.location.reload()
                } else {
                    alert('❌ Lỗi: ' + result.message)
                }
            })
            .catch(err => {
                console.error(err)
                alert('❌ Lỗi khi xóa sản phẩm')
            })
        }
    })
    */

    function performCategoryDelete(id, button = null, originalText = 'Xóa', onComplete = null) {
        console.log('Starting delete operation for id:', id)
        fetch(`/admin/categories_admin/delete/${id}`, {
            method: 'POST',
            credentials: 'same-origin',
            headers: { 'Content-Type': 'application/json' }
        })
        .then(r => {
            console.log('Response status:', r.status)
            return r.json()
        })
        .then(result => {
            console.log('Delete result:', result)
            
            // Re-enable button
            if (button) {
                button.disabled = false
                button.textContent = originalText
            }
            
            if (result.success) {
                alert('✅ ' + result.message)
                // Force reload to show changes
                window.location.reload(true)
            } else {
                alert('❌ Lỗi: ' + result.message)
            }
            
            // Reset flag
            if (onComplete) onComplete()
        })
        .catch(err => {
            console.error('Delete error:', err)
            
            // Re-enable button on error
            if (button) {
                button.disabled = false
                button.textContent = originalText
            }
            
            alert('❌ Lỗi khi xóa danh mục')
            
            // Reset flag
            if (onComplete) onComplete()
        })
    }
})