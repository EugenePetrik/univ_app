# frozen_string_literal: true

class LoginsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]

  def new; end

  def create
    student = Student.find_by(email: params[:logins][:email].downcase)

    if student&.authenticate(params[:logins][:password])
      session[:student_id] = student.id
<<<<<<< 868afc48e0764b9b6c14d1efc3f31f30fa74ae09
      flash[:notice] = t('.success_log_in')
      redirect_to student
    else
      flash.now[:notice] = t('.something_was_wrong')
=======
      flash[:notice] = 'You have successfully logged in'
      redirect_to root_path
    else
      flash.now[:notice] = 'Something was wrong with your login information'
>>>>>>> Add rubocop-rspec gem
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
<<<<<<< 868afc48e0764b9b6c14d1efc3f31f30fa74ae09
    flash[:notice] = t('.success_log_out')
=======
    flash[:notice] = 'You have successfully logged out'
>>>>>>> Add rubocop-rspec gem
    redirect_to root_path
  end
end
