class BankAccountsController < ApplicationController

  skip_before_filter :admin_required, :only => [:transactions]
  before_filter :authorize_with_token, :only => [:transactions]

  # GET /bank_accounts
  # GET /bank_accounts.xml
  def index
    @bank_accounts = BankAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bank_accounts }
    end
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.xml
  def show
    @bank_account = BankAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bank_account }
    end
  end

  # GET /bank_accounts/new
  # GET /bank_accounts/new.xml
  def new
    @bank_account = BankAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bank_account }
    end
  end

  # GET /bank_accounts/1/edit
  def edit
    @bank_account = BankAccount.find(params[:id])
  end

  # POST /bank_accounts
  # POST /bank_accounts.xml
  def create
    @bank_account = BankAccount.new(params[:bank_account])

    respond_to do |format|
      if @bank_account.save
        flash[:notice] = 'BankAccount was successfully created.'
        format.html { redirect_to(@bank_account) }
        format.xml  { render :xml => @bank_account, :status => :created, :location => @bank_account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bank_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bank_accounts/1
  # PUT /bank_accounts/1.xml
  def update
    @bank_account = BankAccount.find(params[:id])

    respond_to do |format|
      if @bank_account.update_attributes(params[:bank_account])
        flash[:notice] = 'BankAccount was successfully updated.'
        format.html { redirect_to(@bank_account) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bank_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.xml
  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy

    respond_to do |format|
      format.html { redirect_to(bank_accounts_url) }
      format.xml  { head :ok }
    end
  end

  def transactions
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : 1.month.ago

    hbci do
      @transactions = @bank_account.get_transactions(start_date)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @transactions }
    end
  end

  protected

  def authorize_with_token
    if params[:auth_token]
      @bank_account = BankAccount.find_by_token(params[:auth_token])
      unless @bank_account
        render :text => "Authorization failed", :status => 401 and return
      end
    else
      @bank_account = BankAccount.find(params[:id])
      admin_required
    end
  end
end
