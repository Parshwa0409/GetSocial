User.create!(
    name: "Parshwa",
    email: "parshwapatil9@gmail.com",
    password: "password",
    bio: "Hey, There I'm Using GetSocial",
    profile_picture: {
        io: File.open("app/assets/images/user_avatar.png"),
        filename: "user_avatar.png"
    }
)

User.create!(
    name: "Parshwa",
    email: "parshwapatilnhce@gmail.com",
    password: "password",
    bio: "Hey, There I'm Using GetSocial",
    profile_picture: {
        io: File.open("app/assets/images/user_avatar.png"),
        filename: "user_avatar.png"
    }
)

User.create!(
    name: "Lisha",
    email: "lisha2002@gmail.com",
    password: "password",
    bio: "Hey, There I'm Using GetSocial",
    profile_picture: {
        io: File.open("app/assets/images/user_avatar.png"),
        filename: "user_avatar.png"
    }
)

User.create!(
    name: "Manikanta",
    email: "mani.p@gmail.com",
    password: "password",
    bio: "Hey, There I'm Using GetSocial",
    profile_picture: {
        io: File.open("app/assets/images/user_avatar.png"),
        filename: "user_avatar.png"
    }
)

User.create!(
    name: "Prathiksha",
    email: "prk@gmail.com",
    password: "password",
    bio: "Hey, There I'm Using GetSocial",
    profile_picture: {
        io: File.open("app/assets/images/user_avatar.png"),
        filename: "user_avatar.png"
    }
)


user_ids = (User.first.id..User.last.id).map { |i|  i }
cars = ['Bugatti', 'Ferrari', 'Koenigsegg', 'Lamborghini', 'McLaren', 'Pagani', 'Porsche']
captions = [
    "Engineering excellence at its finest.",
    "Where passion meets performance.",
    "Innovative design, breathtaking speed.",
    "Unleashing the beast within.",
    "Precision crafted for speed enthusiasts.",
    "Art and engineering in perfect harmony.",
    "Legendary performance, everyday usability."
]


50.times do 
    user = User.find(user_ids.sample())
    idx = ((0...cars.length).map {|i| i}).sample()

    puts("#{user.name} => #{cars[idx]}: #{captions[idx]}")

    user.posts.create(
        caption:captions[idx],
        image:{
                io: File.open("/Users/parshwapatil/Desktop/GetSocial/app/assets/images/#{cars[idx]}.png"),
                filename: "#{cars[idx]}.png"
        }
    )
end
