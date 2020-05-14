# frozen_string_literal: true

class AnnouncementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Announcement, :read)
  end

  def create?
    @user.can?(Announcement, :create)
  end

  def destroy?
    @user.can?(Announcement, :destroy)
  end

  def update?
    @user.can?(Announcement, :update)
  end

  def permitted_attributes
    klass = Announcement
    return unless @user.can?(klass, :create) || @user.can?(klass, :update)

    %i[start_at end_at title body]
  end
end
