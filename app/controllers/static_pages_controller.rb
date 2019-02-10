class StaticPagesController < ApplicationController
  def team
  end
  def contact
  end
  def index
    # @gossip = Gossip.all.order('created_at DESC')
    # affichage des derniers gossips
    @gossip = Gossip.all.last(9).reverse
    @gossip_number = Gossip.all.count
  end

end
