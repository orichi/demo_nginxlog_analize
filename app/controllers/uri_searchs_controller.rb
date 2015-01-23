class UriSearchsController < ApplicationController
  def login_query
    date_start = 7.days.ago.strftime("%Y%m%d")
    date_end   = 1.days.ago.strftime("%Y%m%d")
    test_ip = '106.37.187.10'
    login_path = '/loginDex'
    @data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and uri_sub = '#{login_path}' and code = 200 group by date")
    @user_data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and uri_sub = '#{login_path}' and code = 200 and ip != '#{test_ip}' group by date")
  end
end
