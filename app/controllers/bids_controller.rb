class BidsController < ApplicationController
    def create
      @bid = current_user.bids.new(bid_params)
  
      if @bid.valid? @bid.save
        @bid.rice.update(bidding_price: @bid.bidding_price)
        redirect_to buyer_path, notice: "Bid placed successfully."
      else
        redirect_to buyer_path, notice: "Bid placed must be greater than the bidding price."
      end
    end
  
    private
  
    def bid_params
      params.require(:bid).permit(:rice_id, :bidding_price)
    end
  end
  