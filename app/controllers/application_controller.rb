class ApplicationController < ActionController::Base
    before_action :configure_devise_parameters, if: :devise_controller?

    def configure_devise_parameters
      #méthode pour obtenir des paramètres (nom, mail, etc.) à partir de demandes comme que la connexion et la nouvelle inscription 
      #cela autorise la connection ou MAJ du compte
      #https://www.youtube.com/watch?v=OQcKtouJoHg
      devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name, :last_name, :description, :email, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name, :last_name, :description, :email, :password, :password_confirmation)}
    end
end
