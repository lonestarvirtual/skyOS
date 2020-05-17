# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user
        scope.all
      else
        scope.where(private: false)
      end
    end
  end

  def index?
    true
  end

  def create?
    @user&.can?(Article, :create)
  end

  def destroy?
    @user&.can?(Article, :destroy)
  end

  def update?
    @user&.can?(Article, :update)
  end

  def permitted_attributes
    unless @user&.can?(Equipment, :create) || @user&.can?(Equipment, :update)
      return
    end

    %i[title content private]
  end
end
