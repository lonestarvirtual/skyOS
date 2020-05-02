# frozen_string_literal: true

module Admin
  class PirepsController < ApplicationController
    include PirepCommentable

    def index
      authorize Pirep, :index?
      @q = Pirep.ransack(params[:q])
      @q.status_name_eq = 'Submitted' unless params[:q]
      default_sort = ['created_at desc', 'date desc']
      @q.sorts = default_sort if @q.sorts.empty?
      @pireps = @q.result.page(params[:page])
    end

    def destroy
      @pirep = Pirep.find(params[:id])
      authorize @pirep, :destroy?

      if @pirep.destroy
        flash[:success] = 'PIREP deleted'
        redirect_to admin_pireps_path
      else
        flash[:danger] = 'Unable to delete PIREP'
        render :edit
      end
    end

    def edit
      @pirep = Pirep.find(params[:id])
      authorize @pirep, :edit?

      @pirep.comments.build(author: current_pilot)
    end

    def update
      @pirep = Pirep.find(params[:id])
      authorize @pirep, :update?

      @pirep.assign_attributes(permitted_attributes(@pirep))

      # set/enforce comment author
      comment_author(@pirep)

      if @pirep.save
        flash[:success] = 'PIREP updated'
        redirect_to admin_pireps_path
      else
        render :edit
      end
    end
  end
end
