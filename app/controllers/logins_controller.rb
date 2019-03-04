class LoginsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]

  def new

  end

  def create
    student = Student.find_by(email: params[:logins][:email].downcase)

    if student && student.authenticate(params[:logins][:password])
      session[:student_id] = student.id
<<<<<<< bf409ef2fed979273e26ee7c9dc3e852648284af
      flash[:notice] = t('.success_log_in')
      redirect_to student
=======
      flash[:notice] = "You have successfully logged in"
      redirect_to root_path
>>>>>>> Move to Main page after login
    else
      flash.now[:notice] = t('.something_was_wrong')
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:notice] = t('.success_log_out')
    redirect_to root_path
  end
end
