class TemplatesController < ApplicationController

	before_filter {|controller| controller.set_selected("templates")}
	def index
		@templates = current_user.templates
	end

	def new
		@templates = Template.new
		@criteriaNames = ['opt1','opt2','opt3','opt4','opt5']
	end

	def create
		template = current_user.templates.create(criteria:{ payload:[params[:criteria]]},name:params[:template_name])
	end

	def show
		@template = Template.find(params[:id])
	end

	def update
	end

	def delete
	end
end
