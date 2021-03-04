class TransactionsController < ApplicationController
  before_action :logged_in_user

  def home
  end

  def new
    @transaction  = current_user.transactions.new
  end

  def index
    @transactions = Transaction.all
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      flash[:success] = "transaction has been created!"
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
  end

  def update
    @transaction = current_user.transactions.find(params[:id])
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "transaction updated"
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    if @transaction 
      @transaction.destroy
      flash[:success] = "transaction has been deleted"
    else
      flash[:alert] = "Error"
    end
    redirect_to root_path
  end

  def show
    @transaction = transaction.find(params[:id])
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name)
  end

end
