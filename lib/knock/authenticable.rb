module Knock::Authenticable
  def current_user
    @current_user ||= begin
      token = params[:token] || request.headers['HTTP_AUTHENTICATION'].split.last
      Knock::AuthToken.new(token: token).current_user
    rescue
      nil
    end
  end

  def authenticate
    head :unauthorized unless current_user
  end
end
