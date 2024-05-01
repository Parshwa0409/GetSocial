module PostsHelper
    # if user_liked a post or not need in both "home/index" && "post/show", but then all the interaction buttons are linked to _post only!!!!
    def like_button(post, current_user)
        like = Like.find_by(user_id: current_user.id, post_id: post.id)
        class_like = like.present? ? "liked" : "not-liked"
        txt = like.present? ? "❤️" : "♡"

        button_tag(class: "btn btn-sm btn-outline-dark like-btn #{class_like}", data: { post_id: post.id }) do
            txt.html_safe
        end
    end


    def render_post_if_following(user)
        if active_user.following?(user) || active_user.myself?(user)
            yield
        end
    end

    def render_content_if_not_following(user)
        unless active_user.following?(user) || active_user.myself?(user)
            yield
        end
    end

end
