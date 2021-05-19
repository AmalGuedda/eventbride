class UserMailer < ApplicationMailer
    default from: 'no-reply@monsite.fr'
 
    def welcome_email(user)
      #récupère l'instance user pour passer à la view en @user
      @user = user 
  
      #définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 
  
      #permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue dans UrbainEvents !') 
    end
  
    def new_guest_send(attendance)
      #récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @attendance = attendance
      @admin = User.find(@attendance.event.admin_id)
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @admin.email, subject: 'Votre nouvel invite !') 
    end
 
 end