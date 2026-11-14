CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME ,@batch_start DATETIME , @batch_end DATETIME;
	BEGIN TRY
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';


		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @batch_start = GETDATE()
		SET @start_time = GETDATE();
		
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info; /* To nut duplicate the rows */

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info; /* To nut duplicate the rows */

		PRINT '>> Inserting Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details; /* To nut duplicate the rows */
	
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'

		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12; /* To nut duplicate the rows */

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101; /* To nut duplicate the rows */

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2; /* To nut duplicate the rows */

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,   /*Tell it that table start from row 2 due to headers */
		FIELDTERMINATOR = ',',
		TABLOCK /* Lock table during insertion */
		);
		SET @end_time = GETDATE();
		SET @batch_end = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond,@start_time,@end_time) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'
		PRINT '>> Batch Load Duration: ' + CAST(DATEDIFF(millisecond,@batch_start,@batch_end) AS NVARCHAR) + ' millisecond'
		PRINT '-------------------------'


	END TRY
	BEGIN CATCH
		
		PRINT '===============================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE' + CAST(ERROR_STATE()AS NVARCHAR);
		PRINT '===============================';


	END CATCH
END


