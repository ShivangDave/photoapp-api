class Api::V1::ProfilesController < ApplicationController
    
    before_action :find_profile, only: [:update]

    def index
        @profiles = Api::V1::Profile.all
        secure_response({ :profiles => @profiles.as_json }, :ok)
    end

    def update
        if @profile
            @profile.update(profile_params)
        end
        check_persistance
    end

    def check_persistance
        if @profile
            secure_response(@profile.as_json, :ok)
        else
            secure_response({ :message => "Something went wrong.."}, :bad_request)
        end
    end

    private
    def profile_params
        if decode_request
            decode_request.require(:profile).permit(:profile_name,:location)
        end
    end

    def find_profile
        begin
            @profile = Api::V1::Profile.friendly.find(params[:id])
        rescue
            @profile = nil
        end
    end

end
