create table public.cashbook_picnic_2026 (
  id uuid not null default gen_random_uuid (),
  payee text not null,
  receiver text not null,
  remarks text null,
  amount numeric(12, 2) not null,
  type character varying(10) not null,
  from_onsite boolean not null,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  constraint cashbook_picnic_2026_pkey primary key (id),
  constraint cashbook_picnic_2026_type_check check (
    (
      (type)::text = any (
        (
          array[
            'income'::character varying,
            'expense'::character varying
          ]
        )::text[]
      )
    )
  )
) TABLESPACE pg_default;

create table public.notes (
  id uuid not null default gen_random_uuid (),
  title text not null,
  content text null,
  created_at timestamp with time zone not null default timezone ('utc'::text, now()),
  updated_at timestamp with time zone not null default timezone ('utc'::text, now()),
  constraint notes_pkey primary key (id)
) TABLESPACE pg_default;

create table public.picnic_TCS (
  id uuid not null default gen_random_uuid (),
  name character varying(255) not null,
  location character varying(255) null,
  coordinates numeric[] not null,
  phone_number character varying(20) not null,
  head_count integer null,
  kids_count integer null,
  food_type character varying(100) null,
  created_at timestamp without time zone null default now(),
  updated_at timestamp without time zone null default now(),
  transport_required boolean null default false,
  constraint picnic_2026_pkey primary key (phone_number),
  constraint picnic_2026_head_count_check check ((head_count >= 0)),
  constraint picnic_2026_kids_count_check check ((kids_count >= 0))
) TABLESPACE pg_default;

create table public.picnic_TCS_root (
  id serial not null,
  bus_source_coordinates numeric[] null,
  bus_source_name character varying(255) null,
  picnic_spot numeric[] null,
  picnic_spot_name character varying(255) null,
  picnic_price_per_person numeric(10, 2) null,
  payment_status jsonb null default '{}'::jsonb,
  created_at timestamp without time zone null default now(),
  updated_at timestamp without time zone null default now(),
  constraint picnic_2026_root_pkey primary key (id)
) TABLESPACE pg_default;