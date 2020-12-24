class Transfer
  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    #state = true
    #state = false if !sender.valid?
    #state = false if !receiver.valid?
    #state = false if status == "complete"
    sender.valid? && receiver.valid? && @status == "pending" && sender.balance > amount
  end

  def execute_transaction
    if valid?
      #binding.pry
      sender.deposit(amount * -1)
      receiver.deposit(amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if status == "complete"
      sender.deposit(amount)
      receiver.deposit(amount*-1)
      @status = "reversed"
    end
  end
end
