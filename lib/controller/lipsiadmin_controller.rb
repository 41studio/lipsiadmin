module Lipsiadmin#:nodoc:
  module Controller#:nodoc:
    # Base Backend Controller that define:
    #
    #   layout false
    #   before_filter :backend_login_required
    #   helper Lipsiadmin::View::Helpers::BackendHelper
    #
    class Base < ActionController::Base
      include Lipsiadmin::AccessControl::Authentication
      layout false
      before_action :backend_login_required
      helper Lipsiadmin::View::Helpers::BackendHelper
    end
  end
end
