# 🌿 Picnic Location Planner (2026)

A full-stack, serverless web application designed to streamline group picnic coordination, pickup logistics, route optimization, payment tracking, and bus fleet management. Built with vanilla HTML/CSS/JavaScript, Leaflet.js for interactive mapping, and Supabase as the real-time backend[cite: 1, 2].

---

## ✨ Key Features

### 1. Participant Portal (`index.html`)
* **Interactive Pickup Registration:** Participants can register with their name, phone number (`+91`), total head count, kids count, and dietary preference (`Veg` / `Non-Veg`)[cite: 1].
* **Smart Geocoding & Pin-Drop Map:** Toggling **Transport Required** unlocks location autocomplete (powered by `geocode.maps.co`) and interactive map pinning via Leaflet & OpenStreetMap[cite: 1].
* **Nearest-Neighbor Route Optimization:** Automatically calculates an optimized pickup sequence from the starting bus depot through all pickup stops to the final picnic destination using the Haversine distance formula[cite: 1].
* **Google Maps & CSV Export:** One-click launch of the full multi-waypoint route in Google Maps, plus password-protected CSV export for organizers[cite: 1].
* **Live Summary & Timetable:** Real-time KPI breakdown (Total Participants, Adults, Kids, Veg, Non-Veg), dynamic bus route timelines, buffet menu showcase, and privacy-masked participant directory[cite: 1].

### 2. Organizer Control Center (`admin.html`)
* **Password-Protected Access:** Secures administrative controls behind an organizer passcode prompt[cite: 2].
* **Route & Destination Configurator:** Interactive dual-pin map editor to set and update the Bus Source Point and Picnic Spot coordinates in real time[cite: 2].
* **Dynamic CMS & Feature Toggles:**
  * Manage live bulletin announcements (`Notifications`)[cite: 2].
  * Enable or disable public registration on the fly (`UI_Enabler`)[cite: 2].
  * Edit, validate, and format the structured JSON bus schedule (`Route_Plan`)[cite: 2].
* **Payment Tracking Dashboard:** Toggle paid/unpaid status per registration, monitor live paid vs. unpaid headcounts, and export payment reports to CSV[cite: 2].
* **Bus Capacity & Fleet Planner:** Create buses with custom seat capacities and marker colors, assign participants to specific vehicles, and track live seat occupancy[cite: 2].

---

## 🛠️ Tech Stack

* **Frontend:** Semantic HTML5, Modern CSS3 (Custom Properties, Grid/Flexbox), Vanilla ES6+ JavaScript[cite: 1, 2]
* **Typography:** Google Fonts (`Plus Jakarta Sans`, `Inter`, `JetBrains Mono`)
* **Mapping & Geocoding:** [Leaflet.js](https://leafletjs.com/), OpenStreetMap tiles, and `geocode.maps.co` search API[cite: 1, 2]
* **Backend & Database:** [Supabase](https://supabase.com/) (PostgreSQL via `@supabase/supabase-js` CDN)[cite: 1, 2]

---

## 🗄️ Supabase Database Schema

To run this project with your own Supabase instance, create the following three tables:

### 1. `picnic_2026` (Participant Registrations)
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `int8` (PK) | Auto-incrementing unique identifier[cite: 1, 2] |
| `name` | `text` | Participant full name[cite: 1, 2] |
| `transport_required` | `boolean` | Whether bus pickup is needed[cite: 1, 2] |
| `location` | `text` | Landmark or pickup area name[cite: 1, 2] |
| `coordinates` | `float8[]` / `jsonb` | Stored as `[longitude, latitude]`[cite: 1, 2] |
| `phone_number` | `text` | 10-digit mobile number[cite: 1, 2] |
| `head_count` | `int4` | Total members in the group[cite: 1, 2] |
| `kids_count` | `int4` | Number of children included in head count[cite: 1, 2] |
| `food_type` | `text` | `'Veg'` or `'Non-Veg'`[cite: 1, 2] |
| `updated_at` | `timestamptz` | Last update timestamp[cite: 1] |

### 2. `picnic_2026_root` (Core Event & Payment Config)
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `int8` (PK) | Single-row configuration ID[cite: 2] |
| `bus_source_name` | `text` | Starting depot name[cite: 2] |
| `bus_source_coordinates` | `float8[]` / `jsonb` | Stored as `[longitude, latitude]`[cite: 1, 2] |
| `picnic_spot_name` | `text` | Destination venue name[cite: 1, 2] |
| `picnic_spot` | `float8[]` / `jsonb` | Stored as `[longitude, latitude]`[cite: 1, 2] |
| `payment_status` | `jsonb` | Map of participant payment statuses keyed by participant ID[cite: 2] |
| `updated_at` | `timestamptz` | Last update timestamp[cite: 2] |

### 3. `notes` (Key-Value JSON & Content Store)
Used as a lightweight document store queried by unique `title` keys (`Notifications`, `UI_Enabler`, `Route_Plan`, `Bus_Details`, `Bus_Assignments_Data`, `Bus_Assignments`)[cite: 1, 2]:
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `int8` (PK) | Unique identifier[cite: 2] |
| `title` | `text` (Unique) | Configuration key name[cite: 1, 2] |
| `content` | `text` | Plain text or serialized JSON payload[cite: 1, 2] |
| `updated_at` | `timestamptz` | Last update timestamp[cite: 2] |

---

## 🚀 Getting Started

1. **Clone or Download** the repository files (`index.html`, `admin.html`, `cashbook.html`, `notes.html`)[cite: 1, 2].
2. **Configure Supabase:**
   * Create a new project on [Supabase](https://supabase.com/) and set up the three tables listed above[cite: 1, 2].
   * Replace `supabaseUrl` and `supabaseKey` in the `<script type="module">` blocks of `index.html` and `admin.html` with your project credentials[cite: 1, 2].
3. **Update Passwords & API Keys:**
   * Update the admin and CSV export passcode in `index.html` and `admin.html`[cite: 1, 2].
   * (Optional) Replace the `geocode.maps.co` API key in `index.html` with your own free key[cite: 1].
4. **Deploy:**
   * Because there is no build step required, you can host the files directly on **GitHub Pages**, **Netlify**, **Vercel**, or open `index.html` locally in any modern browser.

---

## 📁 Project Structure

```text
├── index.html      # Public registration, live map, route plan, menu & directory
├── admin.html      # Organizer dashboard for routes, payments, toggles & buses
├── cashbook.html   # Expense & budget ledger (linked via Admin Panel)
├── notes.html      # Organizer scratchpad & notes (linked via Admin Panel)
└── README.md       # Project documentation