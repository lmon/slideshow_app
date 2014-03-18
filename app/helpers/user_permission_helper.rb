# app/helpers/user_permission_helper.rb
module UserPermissionHelper
  def tester number
    "hello world #{number}"
  end

 def user_has_privileges id
 	((current_user && (current_user.id == id)) || (current_user && current_user.admin?))  
  end
 
end