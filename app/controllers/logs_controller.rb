class LogsController < ApplicationController
  def show
    filename = "#{Rails.root}/log/development.log"
    @logs = IO.readlines(filename).join
    @fd = IO.sysopen(filename)
  end

  def get_log_changes
    lines = read_file("#{Rails.root}/log/development.log", params[:lines].to_i)
    render json: { message: lines }, status: 200
  end

  def read_file(filename, number_of_lines)
    output = ''
    File.readlines(filename).last(number_of_lines).each do |line|
      output << line
    end
    output
  end
end