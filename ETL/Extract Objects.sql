-- Extract film data
SELECT
	[t1].[film_id],
	[t1].[title],
	[t1].[description],
	[t1].[release_year],
	[t2].[name] AS 'language',
	[t1].[rental_duration],
	[t1].[rental_rate],
	[t1].[length],
	[t1].[replacement_cost],
	[t1].[rating],
	[t1].[special_features],
	[q].[category]
FROM
	[dbo].[film] [t1]
	JOIN [dbo].[language] [t2]
	ON [t1].[language_id] = [t2].[language_id]
	JOIN
	(
		SELECT
			[st1].[film_id],
			CAST((STRING_AGG([st3].[name],',') WITHIN GROUP (ORDER BY [st3].[name])) AS NVARCHAR(255)) AS 'category'
		FROM
			[dbo].[film] [st1]
			JOIN [dbo].[film_category] [st2]
			ON [st1].[film_id] = [st2].[film_id]
			JOIN [dbo].[category] [st3]
			ON [st2].[category_id] = [st3].[category_id]
		GROUP BY
			[st1].[film_id]
	) [q]
	ON [t1].[film_id] = [q].[film_id]

-- Extract store data
SELECT
	[t1].[store_id],
	[t2].[address],
	[t2].[address2],
	[t2].[district],
	[t3].[city],
	[t4].[country],
	[t2].[postal_code],
	[t2].[phone],
	[t5].[first_name] AS 'manager_first_name',
	[t5].[last_name] AS 'manager_last_name'
FROM
	[dbo].[store] [t1]
	JOIN [dbo].[address] [t2]
	ON [t1].[address_id] = [t2].[address_id]
	JOIN [dbo].[city] [t3]
	ON [t2].[city_id] = [t3].[city_id]
	JOIN [dbo].[country] [t4]
	ON [t3].[country_id] = [t4].[country_id]
	JOIN [dbo].[staff] [t5]
	ON [t1].[manager_staff_id] = [t5].[staff_id]

-- Extract customer data
SELECT
	[t1].[customer_id],
	[t1].[first_name],
	[t1].[last_name],
	[t1].[email],
	[t2].[address],
	[t2].[address2],
	[t2].[district],
	[t3].[city],
	[t4].[country],
	[t2].[postal_code],
	[t2].[phone],
	[t1].[active] AS 'is_active'
FROM
	[dbo].[customer] [t1]
	JOIN [dbo].[address] [t2]
	ON [t1].[address_id] = [t2].[address_id]
	JOIN [dbo].[city] [t3]
	ON [t2].[city_id] = [t3].[city_id]
	JOIN [dbo].[country] [t4]
	ON [t3].[country_id] = [t4].[country_id]

-- Extract staff data
SELECT
	[t1].[staff_id],
	[t1].[first_name],
	[t1].[last_name],
	[t1].[email],
	[t2].[address],
	[t2].[address2],
	[t2].[district],
	[t3].[city],
	[t4].[country],
	[t2].[postal_code],
	[t2].[phone],
	[t1].[active] AS 'is_active',
	[t5].[manager_staff_id],
	[t1].[username],
	[t1].[password]
FROM
	[dbo].[staff] [t1]
	JOIN [dbo].[address] [t2]
	ON [t1].[address_id] = [t2].[address_id]
	JOIN [dbo].[city] [t3]
	ON [t2].[city_id] = [t3].[city_id]
	JOIN [dbo].[country] [t4]
	ON [t3].[country_id] = [t4].[country_id]
	LEFT OUTER JOIN [dbo].[store] [t5]
	ON [t1].[staff_id] = [t5].[manager_staff_id]

-- Extract inventory data
SELECT
	*
FROM
	[dbo].[inventory]
ORDER BY
	[inventory_id]

-- Extract rental data
SELECT
	[inventory_id],
	[return_date]
FROM
	[dbo].[rental]
ORDER BY
	[inventory_id]

-- Extract payment data
SELECT
	[t1].[customer_id],
	[t3].[film_id],
	[t3].[store_id],
	[t2].[staff_id],
	[t1].[payment_date],
	[t2].[rental_date],
	[t2].[return_date],
	[t1].[amount] AS 'total_amount_paid'
FROM
	[dbo].[payment] [t1]
	JOIN [dbo].[rental] [t2]
	ON [t1].[rental_id] = [t2].[rental_id]
	JOIN [dbo].[inventory] [t3]
	ON [t2].[inventory_id] = [t3].[inventory_id]