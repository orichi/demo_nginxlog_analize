class DashboardsController < ApplicationController
  def index
    date_start = 8.days.ago.strftime("%Y%m%d")
    date_end   = 1.days.ago.strftime("%Y%m%d")
    @data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} group by date")
    @page_data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and is_page = 1 group by date")
    @asset_data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and is_page = 0 group by date")
  end
end
