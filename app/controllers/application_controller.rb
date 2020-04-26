class ApplicationController < ActionController::API
    def secure_response(packet, status)
        msg = JWT.encode(packet,ENV['SUPER_SECRET_USER_KEY'])
        render :json => { :message => msg }, :status => status
    end

    def decode_params
        payload = JWT.decode(params[:_json],ENV['SUPER_SECRET_USER_KEY'])[0]
        decoded_params = ActionController::Parameters.new(payload)
    end
end
