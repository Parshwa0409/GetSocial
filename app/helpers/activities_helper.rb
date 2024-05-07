module ActivitiesHelper
    def render_view_btn_if_requests_Available(request_count)
        if request_count > 0 
            yield
        end
    end

    def do_not_render_view_btn_if_requests_Available(request_count)
        unless request_count > 0 
            yield
        end
    end


end
