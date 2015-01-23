class VectorCodesController < ApplicationController
  # GET /vector_codes
  # GET /vector_codes.json
  def index
    @date = params[:m_date] || 1.days.ago.strftime("%Y%m%d")
    @vector_codes = VectorCode.find_by_sql("select count(ip) as ips, uri_sub, code from nginxlogs where date = #{@date} group by code order by ips desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vector_codes }
    end
  end
  
  def bot
    @date = 1.days.ago.strftime("%Y%m%d")
    @vector_codes = VectorCode.find_by_sql("select bot_agent, count(ip) as ips, uri_sub, code from nginxlogs where date = #{@date} and bot_agent is not null group by bot_agent order by ips desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vector_codes }
    end
  end
  
  
  def bot_show
    @date = 1.days.ago.strftime("%Y%m%d")
    @bot = params[:m_bot]
    @vector_codes = VectorCode.find_by_sql("select bot_agent, count(ip) as ips, uri_sub, code from nginxlogs where date = #{@date} and bot_agent ='#{@bot}' group by uri_sub order by ips desc")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vector_codes }
    end
  end

  # GET /vector_codes/1
  # GET /vector_codes/1.json
  def show
    @vector_code = VectorCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vector_code }
    end
  end

  # GET /vector_codes/new
  # GET /vector_codes/new.json
  def new
    @vector_code = VectorCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vector_code }
    end
  end

  # GET /vector_codes/1/edit
  def edit
    @vector_code = VectorCode.find(params[:id])
  end

  # POST /vector_codes
  # POST /vector_codes.json
  def create
    @vector_code = VectorCode.new(params[:vector_code])

    respond_to do |format|
      if @vector_code.save
        format.html { redirect_to @vector_code, notice: 'Vector code was successfully created.' }
        format.json { render json: @vector_code, status: :created, location: @vector_code }
      else
        format.html { render action: "new" }
        format.json { render json: @vector_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vector_codes/1
  # PUT /vector_codes/1.json
  def update
    @vector_code = VectorCode.find(params[:id])

    respond_to do |format|
      if @vector_code.update_attributes(params[:vector_code])
        format.html { redirect_to @vector_code, notice: 'Vector code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vector_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vector_codes/1
  # DELETE /vector_codes/1.json
  def destroy
    @vector_code = VectorCode.find(params[:id])
    @vector_code.destroy

    respond_to do |format|
      format.html { redirect_to vector_codes_url }
      format.json { head :no_content }
    end
  end
end
