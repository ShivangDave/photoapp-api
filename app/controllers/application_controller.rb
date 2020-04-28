class ApplicationController < ActionController::API
    
    def current_user
        token = request.headers['Access-Token']
        user_id = JWT.decode(token,ENV['SUPER_SECRET_USER_KEY'])
        current = Api::V1::User.find_by(id: user_id)
    end

    def authenticate!
        unless current_user
            return nil
        end
    end
    
    def secure_response(packet, status)
        msg = JWT.encode(packet,ENV['SUPER_SECRET_USER_KEY'])
        render :json => { :message => msg }, :status => status
    end

    def decode_request
        begin
            payload = JWT.decode(params[:_json],ENV['SUPER_SECRET_USER_KEY'])[0]
        rescue
            payload = nil
        end
        
        if payload
            return decoded_params = ActionController::Parameters.new(payload)
        else
            return nil
        end
    end
end
