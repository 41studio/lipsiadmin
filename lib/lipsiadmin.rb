require 'version'
require 'utils/html_entities'
require 'utils/literal'
require 'utils/pdf_builder'
require 'access_control/authentication'
require 'access_control/base'
require 'mailer/pdf_builder'
require 'mailer/exception_notifier'
require 'view/helpers/active_record_helper'
require 'view/helpers/backend_helper'
require 'view/helpers/frontend_helper'
require 'view/helpers/view_helper'
require 'view/helpers/ext_helper'
require 'view/helpers/pdf_helper'
require 'controller/ext'
require 'controller/pdf_builder'
require 'controller/responds_to_parent'
require 'controller/lipsiadmin_controller'
require 'controller/ext'
require 'controller/rescue'
require 'data_base/without_table'
require 'data_base/translate_attributes'
require 'data_base/attachment'
require 'data_base/attachment_table'
require 'data_base/utility_scopes'
require 'haml'
require 'generator'

Haml.init_rails(binding)
Haml::Template.options[:attr_wrapper] = "\""

# Global Extension

ActiveRecord::Base.class_eval do
  include Lipsiadmin::DataBase::TranslateAttributes
  include Lipsiadmin::DataBase::Attachment
  include Lipsiadmin::DataBase::UtilityScopes
end

ActionView::Base.class_eval do
  include Lipsiadmin::View::Helpers::FormHelper
  include Lipsiadmin::View::Helpers::FormTagHelper
  include Lipsiadmin::View::Helpers::DateHelper
  include Lipsiadmin::View::Helpers::CountrySelectHelper
  include Lipsiadmin::View::Helpers::PdfHelper
end

ActionView::Helpers::FormBuilder.send(:include, Lipsiadmin::View::Helpers::FormBuilder)

# deprecated
# ActionView::Helpers::PrototypeHelper::JavaScriptGenerator::GeneratorMethods.class_eval do
#   include Lipsiadmin::View::Helpers::ExtHelper
# end

ActionController::Base.class_eval do
  include Lipsiadmin::Controller::Rescue
  include Lipsiadmin::Controller::PdfBuilder
  include Lipsiadmin::Controller::RespondsToParent
  include Lipsiadmin::Controller::Ext
  include Lipsiadmin::AccessControl::Authentication
end

ActionMailer::Base.class_eval do
  include Lipsiadmin::Mailer::PdfBuilder
  include Lipsiadmin::View::Helpers::PdfHelper
end

# For Attachments
File.send(:include, Lipsiadmin::Attachment::Upfile)

# For javascript objects
Object.send(:include, Lipsiadmin::Utils::Literal)

# Custom CSS and JS
include ActionView::Helpers::AssetTagHelper
stylesheet_link_tag :backend => ["ext", "standard", "backend"]# Not ready for ext 3.0, :backend_slate => ["ext", "ext-slate", "standard", "backend-slate"]
javascript_include_tag :backend => ["ext", "locale", "backend"]
javascript_include_tag :ext     => ["ext", "locale"]

# Add a better organization of locales
if Rails.root.present?
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'backend',  '*.{rb,yml}')]
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'frontend', '*.{rb,yml}')]
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'models',   '*.{rb,yml}')]
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'models',   '**/*.{rb,yml}')]
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'rails',    '*.{rb,yml}')]
  I18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', 'backend',  '*.{rb,yml}')]
end

# Load generator languages
I18n.load_path << File.dirname(__FILE__) + '/locale/it.yml'
I18n.load_path << File.dirname(__FILE__) + '/locale/en.yml'
