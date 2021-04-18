set echo on

CREATE OR REPLACE ATTRIBUTE DIMENSION time_attr_dim
USING time_dim
ATTRIBUTES
 (year_id,
  year_name,
  --year_end_date
  quarter_id,
  quarter_name,
  -- quarter_end_date,
  month_id,
  month_name,
  month_long_name,
  month_end_date)
LEVEL MONTH
  KEY month_id
  MEMBER NAME month_name
  MEMBER CAPTION month_name
  MEMBER DESCRIPTION month_long_name
  ORDER BY month_end_date
  DETERMINES (quarter_id, month_end_date)
LEVEL QUARTER
  KEY quarter_id
  MEMBER NAME quarter_name
  MEMBER CAPTION quarter_name
  MEMBER DESCRIPTION quarter_name
  ORDER BY MAX month_end_date
  DETERMINES (year_id)
LEVEL YEAR
  KEY year_id
  MEMBER NAME year_name
  MEMBER CAPTION year_name
  MEMBER DESCRIPTION year_name
  ORDER BY MAX month_end_date;

  
-- Time hierarchy.

CREATE OR REPLACE HIERARCHY time_hier
USING time_attr_dim
 (month  CHILD OF  quarter CHILD OF   year);
 
-- Product attribute dimension. 
 
CREATE OR REPLACE ATTRIBUTE DIMENSION product_attr_dim
USING product_dim 
ATTRIBUTES
 (department_id,
  department_name,
  category_id,
  category_name)
LEVEL DEPARTMENT
  KEY department_id
  MEMBER NAME department_name
  MEMBER CAPTION department_name
  ORDER BY department_name
LEVEL CATEGORY
  KEY category_id
  MEMBER NAME category_name
  MEMBER CAPTION category_name
  ORDER BY category_name
  DETERMINES(department_id)
ALL MEMBER NAME 'ALL PRODUCTS';

-- Product hierarchy.

CREATE OR REPLACE HIERARCHY product_hier
USING product_attr_dim 
 (category CHILD OF department);

-- Geography attribute dimension.

CREATE OR REPLACE ATTRIBUTE DIMENSION geography_attr_dim
USING geography_dim
ATTRIBUTES
 (region_id,
  region_name,
  country_id,
  country_name,
  state_province_id,
  state_province_name)
LEVEL REGION
  KEY region_id
  MEMBER NAME region_name
  MEMBER CAPTION region_name
  ORDER BY region_name
LEVEL COUNTRY
  KEY country_id
  MEMBER NAME country_name
  MEMBER CAPTION country_name
  ORDER BY country_name
  DETERMINES(region_id)
LEVEL STATE_PROVINCE
  KEY state_province_id
  MEMBER NAME state_province_name
  MEMBER CAPTION state_province_name
  ORDER BY state_province_name
  DETERMINES(country_id)
ALL MEMBER NAME 'ALL CUSTOMERS';

-- Geography hierarchy.

CREATE OR REPLACE HIERARCHY geography_hier
USING geography_attr_dim
 (state_province CHILD OF country CHILD OF region);
  
exit