
-- Use the `ref` function to select from other models
{{ config(materialized='table') }}

with result_table as (

SELECT 
	ROW_NUMBER() OVER() AS SurrogateKey,
	* from (SELECT A.customer_id, A.first_name, A.last_name, A.county, A.load_date as valid_from, MIN(B.end_date) AS valid_to
FROM `company_watch.stage_data` AS A
LEFT JOIN ( SELECT customer_id, first_name, load_date AS end_date FROM `company_watch.stage_data` ) AS B
ON A.customer_id = B.customer_id AND A.load_date < B.end_date
GROUP BY A.customer_id, A.load_date, A.first_name, A.last_name, A.county
ORDER BY A.customer_id, A.load_date)
)

select * from result_table