class ApplicationController < ActionController::API
  def success_response
    @success_response ||= { status: "200", message: "Success" }
  end

  def failed_response
    @failed_response ||= { status: "failed" }
  end
end
