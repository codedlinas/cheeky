-- =====================================================
-- ADD TEST PROFILES FOR UI PREVIEW
-- =====================================================
-- Option 1: Temporarily disable foreign key check (recommended for testing)

-- First, drop the foreign key constraint temporarily
ALTER TABLE profiles DROP CONSTRAINT IF EXISTS profiles_user_id_fkey;

-- Now insert the test profiles
INSERT INTO profiles (user_id, display_name, bio, gender, interested_in, age, photo_url) VALUES
-- Female profiles
('00000000-0000-0000-0000-000000000101', 'Emma', 'Yoga instructor 🧘‍♀️ Plant mom 🌱 Coffee addict ☕', 'female', 'male', 24, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400'),
('00000000-0000-0000-0000-000000000102', 'Olivia', 'Chef by day, Netflix binger by night 🍳📺', 'female', 'male', 26, 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400'),
('00000000-0000-0000-0000-000000000103', 'Ava', 'Adventure awaits! 🏔️ Hiker | Traveler | Dreamer', 'female', 'male', 23, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400'),
('00000000-0000-0000-0000-000000000104', 'Isabella', 'Med student 👩‍⚕️ Will probably cancel plans to sleep', 'female', 'male', 27, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400'),
('00000000-0000-0000-0000-000000000105', 'Sophia', 'Dog mom to 2 golden retrievers 🐕 Beach lover 🏖️', 'female', 'male', 25, 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400'),
('00000000-0000-0000-0000-000000000106', 'Mia', 'Photographer | Capturing moments 📸', 'female', 'male', 22, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400'),
('00000000-0000-0000-0000-000000000107', 'Charlotte', 'Bookworm 📚 | Tea enthusiast | Rainy day lover', 'female', 'male', 28, 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400'),
('00000000-0000-0000-0000-000000000108', 'Amelia', 'Fitness coach 💪 Healthy mind, healthy life', 'female', 'male', 26, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400'),
('00000000-0000-0000-0000-000000000109', 'Luna', 'Artist 🎨 Turning coffee into creativity', 'female', 'male', 24, 'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=400'),
('00000000-0000-0000-0000-000000000110', 'Ella', 'Music producer 🎵 Night owl 🦉', 'female', 'male', 25, 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400'),

-- Male profiles
('00000000-0000-0000-0000-000000000201', 'Liam', 'Software engineer 💻 | Basketball 🏀 | Pizza lover', 'male', 'female', 27, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400'),
('00000000-0000-0000-0000-000000000202', 'Noah', 'Architect | Building dreams one sketch at a time ✏️', 'male', 'female', 29, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400'),
('00000000-0000-0000-0000-000000000203', 'Oliver', 'Chef 👨‍🍳 | Traveling the world one dish at a time', 'male', 'female', 26, 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400'),
('00000000-0000-0000-0000-000000000204', 'James', 'Startup founder 🚀 | Coffee ☕ | Golden hour walks', 'male', 'female', 30, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400'),
('00000000-0000-0000-0000-000000000205', 'William', 'Doctor 🩺 | Gym enthusiast | Dog dad', 'male', 'female', 31, 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400'),
('00000000-0000-0000-0000-000000000206', 'Benjamin', 'Musician 🎸 | Vinyl collector | Night owl', 'male', 'female', 25, 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400'),
('00000000-0000-0000-0000-000000000207', 'Lucas', 'Photographer 📷 | Hiking | Sunset chaser', 'male', 'female', 28, 'https://images.unsplash.com/photo-1534030347209-467a5b0ad3e6?w=400'),
('00000000-0000-0000-0000-000000000208', 'Henry', 'Teacher 📚 | Film buff | Terrible at dancing', 'male', 'female', 27, 'https://images.unsplash.com/photo-1488161628813-04466f872be2?w=400'),
('00000000-0000-0000-0000-000000000209', 'Alexander', 'Lawyer ⚖️ | Gym | Classical music nerd', 'male', 'female', 32, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400'),
('00000000-0000-0000-0000-000000000210', 'Sebastian', 'Personal trainer 💪 | Outdoor adventures | Foodie', 'male', 'female', 26, 'https://images.unsplash.com/photo-1504257432389-52343af06ae3?w=400')

ON CONFLICT (user_id) DO UPDATE SET
  display_name = EXCLUDED.display_name,
  bio = EXCLUDED.bio,
  age = EXCLUDED.age,
  photo_url = EXCLUDED.photo_url;

-- Verify the profiles were added
SELECT display_name, age, gender, bio FROM profiles ORDER BY created_at DESC LIMIT 20;
