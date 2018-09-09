ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :admin_type

  index do
    if authorized? :read, AdminUser.new
      selectable_column
      id_column
      column :email
      column :current_sign_in_at
      column :sign_in_count
      column :created_at
      column :admin_type
      actions
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details", for: @admin do
      if (authorized? :update, @admin) || f.object.id == current_admin_user.id
        f.input :email
        if f.object.id == current_admin_user.id || current_admin_user.admin_type == "full_admin" || current_admin_user.admin_type == "admin_manager"
          f.input :password 
        end
        f.input :admin_type if current_admin_user.admin_type == "full_admin"
      end
    end
    f.actions
  end

end
