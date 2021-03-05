class TransactionsController < ApplicationController
  before_action :logged_in_user

  def home
    if current_user.role == 'admin'
      @transactions = Transaction.all
    else
      @transactions = Transaction.where(user_id: current_user.id)
    end
  end

  def new
    @transaction  = current_user.transactions.new
  end

  def index
    @transactions = Transaction.all
  end

  def create
    exchange_fee = 1.2 #This is the fee that is charged to every customer.
    amountToKobo = transaction_params[:amount].to_i * exchange_fee * 100
    paystackObj =  Paystack.new
    transactions = PaystackTransactions.new(paystackObj)
    p request.base_url
    p request.path

    @transaction = current_user.transactions.build(transaction_params)
    p @transaction
    
    if @transaction.save    
      result = transactions.initializeTransaction(
        :reference => SecureRandom.hex,#"bl1bl3l1-44ffd-44ee-REFERENCE-nnjjk",
        :amount => amountToKobo,
        :email => current_user.email,
        :currency => transaction_params[:origin_currency],
        :callback_url => request.base_url + '/transactions/' + (@transaction.id).to_s
        )
      auth_url = result['data']['authorization_url']
      redirect_to auth_url
    else
      render 'new'
    end
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
  end

  def transfer
    # TODO COMPLETE THE TRANSFER ACTION

    paystackObj =  Paystack.new
    recipient = PaystackRecipients.new(paystackObj)
    # result = recipients.create(
    #   :type => "nuban", #Must be nuban
    #   :name => "Test Plan",
    #   :description => "Bla-bla-bla", 
    #   :account_number => 0123456789, #10 digit account number
    #   :bank_code => "044", #monthly, yearly, quarterly, weekly etc 
    #   :currency => "NGN",
  
    # )

    	
	transfer = PaystackTransfers.new(paystackObj)
	# results = transfers.initializeTransfer(
	# 	:source => "balance", # Must be balance
	# 	:reason => "Your reason",
	# 	:amount => 30000, # Amount in kobo
	# 	:recipient =>  recipient_code, # Unique recipient code
	# 	)

  end

  def update
    paystackObj =  Paystack.new
    transactions = PaystackTransactions.new(paystackObj)
    transaction_reference = request.params[:reference]
    result = transactions.verify(transaction_reference)

    @transaction = current_user.transactions.find(params[:id])
    if @transaction.update_attributes(:txn_id => result['data']['id'], :status => result['data']['status'].to_s)
      flash[:success] = "transaction updated"
      redirect_to root_path
    else
      redirect_back
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
    params.require(:transaction).permit(:amount, :origin_currency, :destination_currency, :txn_id, :status)
  end

end
