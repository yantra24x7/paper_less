class ComponentItemSerializer < ActiveModel::Serializer
  attributes :id, :item_name, :is_view, :file_execute, :file_execute_time, :comp_name, :machie_name, :avatar, :img_url
  #has_one :component
  #has_one :machine
  def img_url
  	#data = "\\192.168.0.237\share\YANTRA\PPL\yantra_ppl\public"
  end
end
