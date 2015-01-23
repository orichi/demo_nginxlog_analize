class StatuscodesController < ApplicationController
  
  def index
    @date = params[:m_date] || 1.days.ago.strftime("%Y%m%d") 
    data = Nginxlog.find_by_sql("select count(id) as ids, code from nginx where date = #{@date} and bot_agent is not null group by code order by code")
    user_data = Nginxlog.find_by_sql("select count(id) as ids, code from nginx where date = #{@date} and bot_agent is null group by code order by code")
    codes = [] << data.map(&:code) << user_data.map(&:code)
    @codes = codes.flatten.uniq!
    @data = generate_hash(data)
    @user_data = generate_hash(user_data)
    
  end
  
  
  def generate_hash(datas)
    hash = {}
    datas.each do |item|
      hash[item.code] = item.ids
    end
    return hash
  end
  
end
