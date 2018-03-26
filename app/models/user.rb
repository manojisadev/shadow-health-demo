class User < ApplicationRecord
  has_many :trivia_questions

  before_save :verify_score

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Pagination limit per page
  self.per_page = 5

  private
  def verify_score
    self.score = 0 if self.score < 0
  end
end
