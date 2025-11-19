# Database Schema Documentation

## Supabase Table: `picnic_2026`

### Schema

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| `id` | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier |
| `name` | VARCHAR(255) | NOT NULL | Participant's name |
| `location` | VARCHAR(255) | | Pickup location description |
| `coordinates` | DECIMAL[] | NOT NULL | Array [longitude, latitude] |
| `phone_number` | VARCHAR(20) | | Contact phone number |
| `head_count` | INTEGER | CHECK >= 0 | Total number of people |
| `kids_count` | INTEGER | CHECK >= 0 | Number of children |
| `food_type` | VARCHAR(100) | | Food preference (Veg/Non-Veg) |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Record creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

### Coordinate Format

The `coordinates` field stores location data as a PostgreSQL array:
- Format: `[longitude, latitude]`
- Example: `[88.3639, 22.5726]` (Kolkata coordinates)

**Important**: PostgreSQL/PostGIS uses [longitude, latitude] order, which is opposite to the common [latitude, longitude] format.

### Field Mapping (Frontend ↔ Database)

| Frontend Field | Database Column |
|----------------|-----------------|
| `name` | `name` |
| `location` | `location` |
| `lat` | `coordinates[1]` |
| `lng` | `coordinates[0]` |
| `phone` | `phone_number` |
| `headCount` | `head_count` |
| `kidsCount` | `kids_count` |
| `food` | `food_type` |

### Setup Instructions

1. **Run the SQL migration**:
   ```sql
   -- Execute the contents of database/schema.sql in your Supabase SQL editor
   ```

2. **Configure Row Level Security** (if needed):
   - Adjust the RLS policies based on your authentication requirements
   - Current policy allows all operations (suitable for development)

3. **Environment Variables**:
   - Update Supabase URL and Key in `index.html`
   - For production, move these to environment variables

### API Operations

The application performs the following Supabase operations:

#### Load All Locations
```javascript
const { data, error } = await supabase
  .from("picnic_2026")
  .select("*");
```

#### Insert New Location
```javascript
const { data, error } = await supabase
  .from("picnic_2026")
  .insert([{
    name: "John Doe",
    location: "Park Street",
    coordinates: [88.3639, 22.5726],
    phone_number: "9876543210",
    head_count: 4,
    kids_count: 2,
    food_type: "Veg"
  }]);
```

#### Update Location
```javascript
const { data, error } = await supabase
  .from("picnic_2026")
  .update({
    name: "Jane Doe",
    head_count: 5,
    updated_at: new Date().toISOString()
  })
  .eq('id', locationId);
```

#### Delete Location
```javascript
const { error } = await supabase
  .from("picnic_2026")
  .delete()
  .eq('id', locationId);
```

### Notes

- The application saves data to both Supabase (primary) and GitHub (backup)
- On page load, Supabase data takes precedence over GitHub data
- Coordinates are automatically converted between array format and lat/lng fields
