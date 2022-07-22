# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

doctor_1 = Doctor.create(
  name: "Dr. Anthony Fauci, MD", 
  photo: "https://dims.healthgrades.com/dims3/MMH/c81d174/2147483647/strip/true/crop/3000x3000+750+0/resize/300x300!/format/webp/quality/75/?url=https%3A%2F%2Fucmscdn.healthgrades.com%2F74%2F8e%2F714c0971403d881ea7b822a4dbcf%2Fgettyimages-1205145301.jpg", 
  bio: "As director of the National Institute of Allergy and Infectious Diseases since 1984, Dr. Anthony Fauci is considered the country’s leading expert on infectious diseases. He’s led federal initiatives to fight novel viruses, including HIV, SARS, the H1N1 pandemic, MERS, Ebola, and is currently one of the go-to experts on COVID-19. A widely-respected physician voice by both sides of the aisle, Dr. Fauci has served under seven presidents and is known for his ability to explain complicated scientific concepts calmly, concisely, and clearly.", 
  speciality: "Infectious diseases", 
  price: 800 )

doctor_2 = Doctor.create(
  name: "Dr. Rochelle Walensky, MD, MPH", 
  photo: "https://dims.healthgrades.com/dims3/MMH/293e300/2147483647/strip/true/crop/5464x5464+859+0/resize/300x300!/format/webp/quality/75/?url=https%3A%2F%2Fucmscdn.healthgrades.com%2Fc3%2F62%2Fc2bcb61a4433bdcffdc8217d03e0%2Fgettyimages-1232981322.jpg", 
  bio: "Dr. Rochelle Walensky is the current director of the Centers for Disease Control and Prevention (CDC), the leading public health institute of the United States. A board-certified infectious disease specialist with a master’s degree in public health, she also serves as administrator of the Agency for Toxic Substances and Disease Registry. Prior to these roles, Dr. Walensky was chief of the Division of Infectious Diseases at Massachusetts General Hospital, where she served on the front lines of the COVID-19 pandemic; she was also a member of the faculty at Harvard Medical School for almost 20 years. An author on more than 200 scientific publications, Dr. Walensky is considered a pioneer in HIV/AIDS research focusing on testing, care, and prevention strategies to develop health policy.", 
  speciality: "Infectious diseases", 
  price: 700 )

doctor_3 = Doctor.create(
  name: "Dr. Sanjay Gupta, MD", 
  photo: "https://dims.healthgrades.com/dims3/MMH/0984121/2147483647/strip/true/crop/2787x2787+407+0/resize/300x300!/format/webp/quality/75/?url=https%3A%2F%2Fucmscdn.healthgrades.com%2F13%2F34%2F63eefec84dd6b10e41907097d328%2Fgettyimages-1183027436.jpg", 
  bio: "Dr. Sanjay Gupta, a practicing neurosurgeon, has become a household name since his start as a medical reporter for CNN in 2001. Now CNN’s Chief Medical Correspondent, the multiple Emmy Award-winning surgeon also serves as an associate professor of neurosurgery at Emory University Hospital and associate chief of neurosurgery at Grady Memorial Hospital in Atlanta, Ga. A man of many talents, his accolades range across the spectrum. In addition to many awards for his humanitarian work through the years, in 2019, he was elected to the National Academy of Medicine, one of the top honors in his field.", 
  speciality: "Neurosurgeon", 
  price: 1000 )
doctor_4 = Doctor.create(name: "Dr. Laurie Glimcher, MD", 
  photo: "https://dims.healthgrades.com/dims3/MMH/7e09a30/2147483647/strip/true/crop/3328x3328+836+0/resize/300x300!/format/webp/quality/75/?url=https%3A%2F%2Fucmscdn.healthgrades.com%2Fc6%2F5b%2F117976164705ae12677d1b551f0b%2Fgettyimages-479371363.jpg", 
  bio: "Dr. Laurie Glimcher is the first female president and CEO of Dana-Farber Cancer Institute; she’s also the Richard and Susan Smith Professor of Medicine at Harvard Medical School. A former president of the American Association of Immunologists, Dr. Glimcher is considered a trailblazer in cancer research and has published more than 350 articles and papers on the topic. She also speaks around the world about cancer, immunology, skeletal biology, and translational medicine and also promotes the importance of improved access to care and medical education. In 2018, she received the American Association of Immunologists Lifetime Achievement Award as well as the Indiana University School of Medicine’s Steven C. Beering Award for outstanding research contributions to advancement of biomedical or clinical science.", 
  speciality: "Cancer specialist", 
  price: 900 )

doctor_5 = Doctor.create(
  name: "Dr. Mark Hyman, MD", 
  photo: "https://dims.healthgrades.com/dims3/MMH/ebe8ea4/2147483647/strip/true/crop/2000x2000+0+500/resize/300x300!/format/webp/quality/75/?url=https%3A%2F%2Fucmscdn.healthgrades.com%2Faf%2F94%2F28aa622a4e479015b6068947cd3e%2Fgettyimages-626554570.jpg", 
  bio: "A board-certified internist, Dr. Mark Hyman is one of the country’s most well-known promoters of functional medicine. Dedicated to understanding and treating the root causes of chronic illness, Dr. Hyman serves as the head of strategy and innovation at the Cleveland Clinic Center for Functional Medicine; he’s also the founder and medical director of The UltraWellness Center, board president for clinical affairs at the Institute for Functional Medicine, host of the leading health podcast, The Doctor's Pharmacy, and a 14-time New York Times bestselling author.", 
  speciality: "Functional medicine", 
  price: 600 )

doctor_6 = Doctor.create(
  name: "Dr. Fouad. M. Abbas, M.D.", 
  photo: "https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2017/01/05042830/Fouad-Abbas.jpg", 
  bio: "Dr. Abbas is a well-known Gynecologist/Oncologist. His specialisation field is Oncologist of Obstetrician and Gynecology. He is also considered to be one of the best doctors of Oncology in the world. The term Oncology is the study of cancer. Dr. Abbas graduated from the University of Maryland School of Medicine in 1986. Currently, he is affiliated with Medstar Harbor Hospital and Sinai Hospital Of Baltimore. Dr. Abbas has received many awards including the CREOG National Faculty Award in resident education and was also awarded the Top Doctor by Baltimore Magazine.", 
  speciality: "Obstetrics-Gynecology",
  price: 800 )

now = DateTime.now

user_1 = User.create(
  user_name: "bobbob", email: "bob@fake", 
  # password: "123456"
)
user_2 = User.create(
  user_name: "janejane", email: "jane@fake", 
  # password: "123456"
)

appointment_1 = Appointment.create(user: user_1, doctor: doctor_1, date: now)
appointment_2 = Appointment.create(user: user_1, doctor: doctor_2, date: now.next_day)
appointment_2 = Appointment.create(user: user_1, doctor: doctor_3, date: now.next_day.next_day)
appointment_3 = Appointment.create(user: user_2, doctor: doctor_1, date: now.next_day)
appointment_4 = Appointment.create(user: user_2, doctor: doctor_2, date: now.next_day.next_day)