# User.create!(
#     name: "Lisha",
#     email: "l.ranganath@gmail.com",
#     password: "password",
#     bio: "Hey, There I'm Using GetSocial",
#     profile_picture: {
#         io: File.open("app/assets/images/user_avatar.png"),
#         filename: "user_avatar.png"
#     }
# )

# User.create!(
#     name: "Manikanta",
#     email: "mani.p@gmail.com",
#     password: "password",
#     bio: "Hey, There I'm Using GetSocial",
#     profile_picture: {
#         io: File.open("app/assets/images/user_avatar.png"),
#         filename: "user_avatar.png"
#     }
# )

# User.create!(
#     name: "Prathiksha",
#     email: "prk@gmail.com",
#     password: "password",
#     bio: "Hey, There I'm Using GetSocial",
#     profile_picture: {
#         io: File.open("app/assets/images/user_avatar.png"),
#         filename: "user_avatar.png"
#     }
# )

# user = User.find(3)

# user.posts.create(
#     caption:"Ever asked a boy to imagine a car?\nHe imagines a Red Ferrari!",
#     image:{
#                 io: File.open("/Users/pbpatil/Downloads/Ferrari.png"),
#                 filename: "Ferrari.png"
#             }
# )

# user.posts.create(
#     caption:"I'm the ghost 👻",
#     image:{
#                 io: File.open("/Users/pbpatil/Downloads/Koenigsegg.png"),
#                 filename: "Koenigsegg.png"
#             }
# )

# user.posts.create(
#     caption:"If only there was a perfect thing in the world, It would be a Pagani 🚀",
#     image:{
#                 io: File.open("/Users/pbpatil/Downloads/Pagani.png"),
#                 filename: "Pagani.png"
#             }
# )

User.find(3).posts.create(
    caption:"I don't have to introduce myself 😈",
    image:{
                io: File.open("/Users/pbpatil/Downloads/Bugatti.png"),
                filename: "Bugatti.png"
            }
)