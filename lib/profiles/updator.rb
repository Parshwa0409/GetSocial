module Profiles
    class Updator
        def self.call(user, params)
            if user.update(params)
                return true
            else
                return false
            end
        end
    end
end
