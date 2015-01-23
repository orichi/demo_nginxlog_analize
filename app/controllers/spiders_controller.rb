class SpidersController < ApplicationController
  def basic
    date_start = 4.days.ago.strftime("%Y%m%d")
    date_end   = 1.days.ago.strftime("%Y%m%d")
    @data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and bot_agent is not null group by date")
    @page_data = Nginxlog.find_by_sql("select date, count(id) as ids from nginx where date >= #{date_start} and date <= #{date_end} and is_page = 1 and bot_agent is not null group by date")

  end
  
  def folder
    @date = params[:m_date] || 1.days.ago.strftime("%Y%m%d")
    @data = VectorCode.find_by_sql("select uri_sub,count(id) as ids from nginx where date=#{@date} and is_page =1 and bot_agent is not null group by uri_sub order by ids desc limit 20")
  end
  
  def page
    @date = params[:m_date] || 1.days.ago.strftime("%Y%m%d")
    @data = VectorCode.find_by_sql("select bot_agent, count(id) as ids from nginx where date = #{@date} and is_page = 1  and bot_agent is not null group by bot_agent order by ids desc")

  end
  
  def custom
    @date = params[:m_date] || 1.days.ago.strftime("%Y%m%d")
    @bots = VectorCode.find_by_sql("select bot_agent from nginx where date=#{@date} and bot_agent is not null and is_page = 1 group by bot_agent")
    if params[:agent]
      @data = Nginxlog.find_by_sql("select uri_sub, count(id) as ids from nginx where date = #{@date} and is_page =1 and bot_agent = '#{params[:agent]}' group by uri_sub order by ids desc limit 20")
    end
  end
end
