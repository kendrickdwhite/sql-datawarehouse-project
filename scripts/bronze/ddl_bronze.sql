IF OBJECT_ID ('Bronze.crm_cst_info','U')
    DROP TABLE Bronze.crm_cst_info;
GO
CREATE TABLE Bronze.crm_cst_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50)

)
ALTER TABLE Bronze.crm_cst_info
ADD cst_material_status NVARCHAR(50),
    cst_gender NVARCHAR(50),
    cst_create_date DATE

IF OBJECT_ID ('Bronze.crm_sales_details','U')
    DROP TABLE Bronze.crm_sales_details;
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

IF OBJECT_ID ('Bronze.prd_info','U')
    DROP TABLE Bronze.prd_info;
CREATE TABLE Bronze.prd_info(
prd_id NVARCHAR(50),
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE

)

IF OBJECT_ID ('Bronze.cust_az12','U')
    DROP TABLE Bronze.cust_az12;
CREATE TABLE Bronze.cust_az12 (
    cid   NVARCHAR(50),
    bdate DATE,
    gen   NVARCHAR(10)
);

IF OBJECT_ID ('Bronze.erp_loc_a101','U')
    DROP TABLE Bronze.erp_loc_a101;
CREATE TABLE Bronze.erp_loc_a101 (
    cid   NVARCHAR(50),
    entry NVARCHAR(50)
);

IF OBJECT_ID ('Bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE Bronze.erp_px_cat_g1v2
CREATE TABLE Bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
    BEGIN
        DECLARE @startTime DATETIME, @endtime DATETIME,
            @batchStartTime DATETIME, @batchEndTime DATETIME
        BEGIN TRY
           SET @batchStartTime = GETDATE();
            PRINT ('=============================');
            PRINT ('Loading data into Bronze layer tables')
            PRINT ('=============================');
            PRINT ('LOADING CRM TABLES')
            PRINT ('=============================');
            PRINT 'Truncating and loading Bronze.crm_cst_info,'
            SET @startTime = GETDATE();
            TRUNCATE TABLE Bronze.crm_cst_info
            BULK INSERT Bronze.crm_cst_info
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_crm\cust_info.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )

            TRUNCATE TABLE Bronze.crm_prd_info
            BULK INSERT Bronze.crm_prd_info
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_crm\prd_info.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )

            TRUNCATE TABLE Bronze.crm_sales_details
            BULK INSERT Bronze.crm_sales_details
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_crm\sales_details.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )
            SET @endtime = GETDATE();
            PRINT ('Time elapsed: ' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR(10)) + ' seconds')
            PRINT ('=============================');

            PRINT ('LOADING ERP TABLES')
            SET @startTime = GETDATE();
            TRUNCATE TABLE Bronze.erp_px_cat_g1v2
            BULK INSERT Bronze.erp_px_cat_g1v2
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_erp\PX_CAT_G1V2.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )


            TRUNCATE TABLE Bronze.erp_loc_a101
            BULK INSERT Bronze.erp_loc_a101
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_erp\LOC_A101.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )

            TRUNCATE TABLE Bronze.erp_cust_az12
            BULK INSERT Bronze.erp_cust_az12
                FROM 'C:\Users\kendr\data-analysis\sql-data-warehouse-project\data\datasets\source_erp\CUST_AZ12.csv'
                WITH (FIRSTROW =2, FIELDTERMINATOR =',', TABLOCK )
            SET @endtime = GETDATE();
            PRINT ('Time elapsed: ' + CAST(DATEDIFF(SECOND,@startTime,@endtime) AS NVARCHAR(10)) + ' seconds')
            PRINT ('=============================');

           SET @batchEndTime = GETDATE();
           PRINT ('Total time for Bronze layer load: ' + CAST(DATEDIFF(SECOND,@batchStartTime,@batchEndTime) AS NVARCHAR(10)) + ' seconds')
           PRINT ('=============================');

           END TRY
        BEGIN CATCH
            PRINT ('=============================');
            PRINT ('Error occurred while loading data into Bronze layer tables')
            PRINT 'ERROR ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) + ': ' + ERROR_MESSAGE()
            PRINT ('=============================');
        END CATCH
END

