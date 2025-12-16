create table public.picnic_2026_root (
  id serial not null,
  bus_source_coordinates numeric[] null,
  bus_source_name varchar(255) null,
  picnic_spot numeric[] null,
  picnic_spot_name character varying(255) null,
  picnic_price_per_person numeric(10, 2) null,
  payment_status jsonb null default '{}'::jsonb,
  created_at timestamp without time zone null default now(),
  updated_at timestamp without time zone null default now(),
  constraint picnic_2026_root_pkey primary key (id)
) TABLESPACE pg_default;