ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

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
    if authorized? :read, AdminUser.new
      f.inputs "Admin Details" do
        f.input :email
        f.input :password
        f.input :password_confirmation
        f.input :admin_type
      end
      f.actions
    end
  end

end
