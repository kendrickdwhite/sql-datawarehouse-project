IF OBJECT_ID ('Bronze.crm_cst_info','U')
    DROP TABLE Bronze.crm_cst_info;
GO
CREATE TABLE Bronze.crm_cst_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50)

)
GO
ALTER TABLE Bronze.crm_cst_info
ADD cst_material_status NVARCHAR(50),
    cst_gender NVARCHAR(50),
    cst_create_date DATE

GO
IF OBJECT_ID ('Bronze.crm_sales_details','U')
    DROP TABLE Bronze.crm_sales_details;
GO
CREATE TABLE Bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT


);
GO
    
IF OBJECT_ID ('Bronze.prd_info','U')
    DROP TABLE Bronze.prd_info;
GO
    
CREATE TABLE Bronze.prd_info(
prd_id NVARCHAR(50),
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE

)
GO
    
IF OBJECT_ID ('Bronze.cust_az12','U')
    DROP TABLE Bronze.cust_az12;
GO
CREATE TABLE Bronze.cust_az12 (
    cid   NVARCHAR(50),
    bdate DATE,
    gen   NVARCHAR(10)
);
GO
    
IF OBJECT_ID ('Bronze.erp_loc_a101','U')
    DROP TABLE Bronze.erp_loc_a101;
GO
CREATE TABLE Bronze.erp_loc_a101 (
    cid   NVARCHAR(50),
    entry NVARCHAR(50)
);
GO
    
IF OBJECT_ID ('Bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE Bronze.erp_px_cat_g1v2
GO
CREATE TABLE Bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO
