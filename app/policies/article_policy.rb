# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Article, :read)
  end

  def create?
    @user.can?(Article, :create)
  end

  def destroy?
    @user.can?(Article, :destroy)
  end

  def update?
    @user.can?(Article, :update)
  end

  def permitted_attributes
    unless @user.can?(Equipment, :create) || @user.can?(Equipment, :update)
      return
    end

    %i[title content private]
  end
end
