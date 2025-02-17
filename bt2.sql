USE ss12;

-- 2)Tạo bảng price_changes để lưu thông tin thay đổi giá
CREATE TABLE price_changes (
    change_id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(100) NOT NULL,
    old_price DECIMAL(10, 2) NOT NULL,
    new_price DECIMAL(10, 2) NOT NULL
);

-- 3) Tạo TRIGGER AFTER UPDATE để ghi lại thay đổi giá sản phẩm
DELIMITER $$
CREATE TRIGGER after_update_orders
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO price_changes (product, old_price, new_price)
        VALUES (OLD.product, OLD.price, NEW.price);
    END IF;
END $$
DELIMITER ;

-- 4) Thực hiện UPDATE giá sản phẩm
UPDATE orders SET price = 1400.00 WHERE product = 'Laptop';
UPDATE orders SET price = 800.00 WHERE product = 'Smartphone';

-- 5) Kiểm tra dữ liệu trong bảng price_changes
SELECT * FROM price_changes;
DROP TRIGGER IF EXISTS after_update_orders;

