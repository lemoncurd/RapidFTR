class SessionsController < ApplicationController

  # GET /sessions/1
  # GET /sessions/1.xml
  def show
    @session = Session.get(params[:id])
    raise ErrorResponse.not_found('invalid session id') if @session.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.xml
  def new

    @session = Session.new(params[:login])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session }
    end
  end


  # POST /sessions
  # POST /sessions.xml
  def create

    @login = Login.new(params[:login])

    @session = @login.authenticate_user

    if @session

      respond_to do |format|
        if @session.save
          @session.put_in_cookie(cookies)
          flash[:notice] = 'Hello ' + @session.user_name
          format.html { redirect_to(@session) }
          format.xml  { render :xml => @session, :status => :created, :location => @session }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @login.errors, :status => :unprocessable_entity }
      end
    end
  end

  def backdoor_login
    raise ErrorResponse.bad_request( "missing user_name param" ) unless params.has_key?( :user_name ) 
    user = User.find_by_user_name(params[:user_name])
    raise ErrorResponse.not_found( "invalid user name" ) if user.nil?

    @session = Session.new(:user_name => params[:user_name])
    @session.save!
    @session.put_in_cookie(cookies)
    flash[:notice] = 'Hello ' + @session.user_name
    respond_to do |format|
      format.html { redirect_to(@session) }
      format.xml  { render :xml => @session, :status => :created, :location => @session }
    end

  end

  # PUT /sessions/1
  # PUT /sessions/1.xml


  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    @session = Session.get_from_cookies(cookies)
    @session.destroy if @session

    respond_to do |format|
      format.html { redirect_to(:login) }
      format.xml  { head :ok }
    end
  end
end
