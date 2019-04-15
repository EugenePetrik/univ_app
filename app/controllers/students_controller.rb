# frozen_string_literal: true

class StudentsController < ApplicationController
  skip_before_action :require_user
  before_action :set_student, only: [:show, :edit, :update]
  before_action :require_same_student, only: [:edit, :update]

  def index
    @students = Student.all
  end

  def show; end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = t('.success_sign_up')
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @student.update(student_params)
<<<<<<< 868afc48e0764b9b6c14d1efc3f31f30fa74ae09
      flash[:notice] = t('.success_updated_profile')
=======
      flash[:notice] = 'You have successfully updated your profile'
>>>>>>> Add rubocop-rspec gem
      redirect_to @student
    else
      render 'edit'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def require_same_student
    if current_user != @student
      flash[:notice] = t('.edit_own_profile')
      redirect_to student_path(current_user)
    end
  end
end
