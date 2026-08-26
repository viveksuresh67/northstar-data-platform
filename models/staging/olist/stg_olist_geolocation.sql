select
    GEOLOCATION_ZIP_CODE_PREFIX as geoloc_zip_code_prefix, 
    cast(GEOLOCATION_LAT as FLOAT) as geoloc_lat, 
    cast(GEOLOCATION_LNG as FLOAT) as geoloc_lng, 
    GEOLOCATION_CITY as geoloc_city, 
    GEOLOCATION_STATE as geoloc_state
from {{ source('olist','olist_geolocation') }}