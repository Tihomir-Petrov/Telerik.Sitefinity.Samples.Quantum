IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE  TABLE_NAME = 'uCommerce_OrderStatusDescription'))
BEGIN
	DROP TABLE uCommerce_OrderStatusDescription
END
GO