-- Create picnic_2026 table in Supabase
CREATE TABLE picnic_2026 (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    coordinates DECIMAL[] NOT NULL,   -- e.g. {88.12345, 22.54321} [longitude, latitude]
    phone_number VARCHAR(20),
    head_count INTEGER CHECK (head_count >= 0),
    kids_count INTEGER CHECK (kids_count >= 0),
    food_type VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create index on coordinates for faster spatial queries (optional)
CREATE INDEX idx_picnic_coordinates ON picnic_2026 USING GIN(coordinates);

-- Enable Row Level Security (optional but recommended)
ALTER TABLE picnic_2026 ENABLE ROW LEVEL SECURITY;

ALTER TABLE picnic_2026 ADD COLUMN transport_required BOOLEAN DEFAULT FALSE;
-- Create a policy that allows all operations (adjust based on your security needs)
CREATE POLICY "Allow all operations on picnic_2026"
ON picnic_2026
FOR ALL
USING (true)
WITH CHECK (true);

-- Sample insert query
-- INSERT INTO picnic_2026 (name, location, coordinates, phone_number, head_count, kids_count, food_type)
-- VALUES ('John Doe', 'Park Street', ARRAY[88.3639, 22.5726], '9876543210', 4, 2, 'Veg');
