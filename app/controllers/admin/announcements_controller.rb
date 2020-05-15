# frozen_string_literal: true

module Admin
  class AnnouncementsController < ApplicationController
    def index
      authorize Announcement, :index?
      @q = policy_scope(Announcement).ransack(params[:q])
      @q.sorts = 'start_at desc' if @q.sorts.empty?
      @announcements = @q.result.page(params[:page])
    end

    def create
      @announcement = Announcement.new(permitted_attributes(Announcement))
      authorize @announcement, :create?

      if @announcement.save
        flash[:success] = 'Announcement created'
        redirect_to admin_announcements_path
      else
        render :new
      end
    end

    def destroy
      @announcement = Announcement.find(params[:id])
      authorize @announcement, :destroy?

      if @announcement.destroy
        flash[:success] = 'Announcement deleted'
        redirect_to admin_announcements_path
      else
        flash[:danger] = 'Unable to delete airport'
        render :edit
      end
    end

    def edit
      @announcement = Announcement.find(params[:id])
      authorize @announcement, :edit?
    end

    def new
      @announcement = Announcement.new
      authorize @announcement, :new?
    end

    def purge
      authorize Announcement, :destroy?

      if Announcement.purge
        flash[:success] = 'Expired announcements deleted'
      else
        flash[:danger] = 'Unable to delete expired announcements'
      end

      redirect_to admin_announcements_path
    end

    def update
      @announcement = Announcement.find(params[:id])
      authorize @announcement, :update?

      if @announcement.update(permitted_attributes(@announcement))
        flash[:success] = 'Announcement updated'
        redirect_to admin_announcements_path
      else
        render :edit
      end
    end
  end
end
